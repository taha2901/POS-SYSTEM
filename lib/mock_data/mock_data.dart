import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// ---------------------------------------------------------------------------
/// كل البيانات الوهمية المشتركة في مكان واحد.
/// أي شاشة جديدة بتقرأ من هنا عشان البيانات تفضل متّسقة بين الشاشات كلها.
/// ---------------------------------------------------------------------------

// ═══════════════════════════════════════════════════════════════════════════
// Models
// ═══════════════════════════════════════════════════════════════════════════

class ProductCategory {
  const ProductCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  final String id;
  final String name;
  final IconData icon;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.barcode,
    required this.categoryId,
    required this.price,
    required this.cost,
    required this.stock,
    required this.minStock,
    required this.unit,
    required this.colorIndex,
    this.brand = 'بدون ماركة',
    this.isActive = true,
  });

  final String id;
  final String name;
  final String sku;
  final String barcode;
  final String categoryId;
  final double price;
  final double cost;
  final int stock;
  final int minStock;
  final String unit;
  final int colorIndex;
  final String brand;
  final bool isActive;

  Color get accentColor =>
      AppColors.productPalette[colorIndex % AppColors.productPalette.length];

  bool get isOutOfStock => stock <= 0;
  bool get isLowStock => stock > 0 && stock <= minStock;

  /// تاريخ الصلاحية (لو المنتج له صلاحية أصلاً)
  DateTime? get expiryDate => MockData.expiryDates[id];

  /// قارب على انتهاء الصلاحية (٣٠ يوم أو أقل)
  bool get isNearExpiry {
    final DateTime? date = expiryDate;
    if (date == null) return false;
    final int days = date.difference(MockData.today).inDays;
    return days <= 30;
  }

  double get profitMargin => price <= 0 ? 0 : ((price - cost) / price) * 100;

  String get categoryName => MockData.categoryById(categoryId)?.name ?? '—';
  IconData get categoryIcon =>
      MockData.categoryById(categoryId)?.icon ?? Icons.inventory_2_outlined;
}

enum CustomerTier { regular, silver, gold }

class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.tier,
    required this.balance,
    required this.points,
    required this.totalPurchases,
    required this.ordersCount,
    required this.lastVisit,
  });

  final String id;
  final String name;
  final String phone;
  final String email;
  final CustomerTier tier;

  /// موجب = ليه فلوس عندنا، سالب = عليه فلوس (آجل)
  final double balance;
  final int points;
  final double totalPurchases;
  final int ordersCount;
  final DateTime lastVisit;

  String get tierLabel => switch (tier) {
        CustomerTier.gold => 'ذهبي',
        CustomerTier.silver => 'فضي',
        CustomerTier.regular => 'عادي',
      };

  String get initials {
    final List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.characters.take(1).toString();
    return '${parts[0].characters.take(1)}${parts[1].characters.take(1)}';
  }
}

class Supplier {
  const Supplier({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.phone,
    required this.email,
    required this.balanceDue,
    required this.totalPurchases,
    required this.ordersCount,
    required this.isActive,
  });

  final String id;
  final String name;
  final String contactPerson;
  final String phone;
  final String email;
  final double balanceDue;
  final double totalPurchases;
  final int ordersCount;
  final bool isActive;
}

class Employee {
  const Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.branchId,
    required this.phone,
    required this.salary,
    required this.hiredAt,
    required this.isActive,
    required this.todaySales,
    required this.roleId,
    required this.lastLogin,
  });

  final String id;
  final String name;
  final String role;
  final String branchId;
  final String phone;
  final double salary;
  final DateTime hiredAt;
  final bool isActive;
  final double todaySales;
  final String roleId;
  final DateTime lastLogin;

  String get branchName => MockData.branchById(branchId)?.name ?? '—';

  String get initials {
    final List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.characters.take(1).toString();
    return '${parts[0].characters.take(1)}${parts[1].characters.take(1)}';
  }
}

class Branch {
  const Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.isMain,
    required this.monthSales,
    required this.managerName,
    required this.isOpen,
    required this.openingHours,
  });

  final String id;
  final String name;
  final String address;
  final String phone;
  final bool isMain;
  final double monthSales;
  final String managerName;

  /// مفتوح دلوقتي ولا لأ (النقطة الملونة جنب اسم الفرع)
  final bool isOpen;
  final String openingHours;

  int get employeesCount =>
      MockData.employees.where((Employee e) => e.branchId == id).length;

  /// مبيعات اليوم — مشتقّة من سلسلة المبيعات عشان تفضل متّسقة مع الداشبورد
  double get todaySales => MockData.seriesFor(days: 1, branchId: id).fold(
        0,
        (double s, SalesPoint p) => s + p.sales,
      );

  double get share => switch (id) {
        'br-1' => 0.5,
        'br-2' => 0.3,
        _ => 0.2,
      };
}

// ── تحليلات المبيعات ───────────────────────────────────────────────────────

/// نقطة يومية في سلسلة المبيعات — أساس كل أرقام الداشبورد
class SalesPoint {
  const SalesPoint({
    required this.date,
    required this.sales,
    required this.profit,
    required this.invoices,
    required this.cash,
    required this.card,
    required this.wallet,
    required this.credit,
  });

  final DateTime date;
  final double sales;
  final double profit;
  final int invoices;
  final double cash;
  final double card;
  final double wallet;
  final double credit;
}

/// إحصائية مبيعات منتج (لجدول أفضل المنتجات)
class ProductSalesStat {
  const ProductSalesStat({
    required this.product,
    required this.units,
    required this.revenue,
  });

  final Product product;
  final int units;
  final double revenue;
}

// ── المصروفات ──────────────────────────────────────────────────────────────

enum ExpenseStatus { pending, approved }

extension ExpenseStatusInfo on ExpenseStatus {
  String get label => switch (this) {
        ExpenseStatus.pending => 'معلّق',
        ExpenseStatus.approved => 'معتمد',
      };
}

class Expense {
  const Expense({
    required this.id,
    required this.date,
    required this.category,
    required this.branchId,
    required this.amount,
    required this.status,
    required this.note,
    required this.createdBy,
  });

  final String id;
  final DateTime date;
  final String category;
  final String branchId;
  final double amount;
  final ExpenseStatus status;
  final String note;
  final String createdBy;

  Branch? get branch => MockData.branchById(branchId);
}

// ── الأجهزة المتصلة ────────────────────────────────────────────────────────

enum DeviceType { printer, cashDrawer, scanner, scale }

extension DeviceTypeInfo on DeviceType {
  String get label => switch (this) {
        DeviceType.printer => 'طابعة إيصال',
        DeviceType.cashDrawer => 'درج الكاش',
        DeviceType.scanner => 'قارئ باركود',
        DeviceType.scale => 'ميزان إلكتروني',
      };

  IconData get icon => switch (this) {
        DeviceType.printer => Icons.print_rounded,
        DeviceType.cashDrawer => Icons.inbox_rounded,
        DeviceType.scanner => Icons.qr_code_scanner_rounded,
        DeviceType.scale => Icons.monitor_weight_rounded,
      };
}

class ConnectedDevice {
  const ConnectedDevice({
    required this.type,
    required this.model,
    required this.port,
    required this.isConnected,
  });

  final DeviceType type;
  final String model;
  final String port;
  final bool isConnected;
}

// ── المشتريات ──────────────────────────────────────────────────────────────

enum PurchaseOrderStatus { draft, confirmed, partiallyReceived, completed }

extension PurchaseOrderStatusInfo on PurchaseOrderStatus {
  String get label => switch (this) {
        PurchaseOrderStatus.draft => 'مسودة',
        PurchaseOrderStatus.confirmed => 'مؤكد',
        PurchaseOrderStatus.partiallyReceived => 'مستلم جزئيًا',
        PurchaseOrderStatus.completed => 'مكتمل',
      };
}

class PurchaseOrderLine {
  const PurchaseOrderLine({
    required this.productId,
    required this.quantity,
    required this.receivedQuantity,
    required this.unitCost,
  });

  final String productId;
  final int quantity;
  final int receivedQuantity;
  final double unitCost;

  Product get product => MockData.productById(productId)!;
  double get total => unitCost * quantity;
  int get remaining => quantity - receivedQuantity;
}

class PurchaseOrder {
  const PurchaseOrder({
    required this.id,
    required this.supplierId,
    required this.date,
    required this.expectedDate,
    required this.status,
    required this.lines,
  });

  final String id;
  final String supplierId;
  final DateTime date;
  final DateTime expectedDate;
  final PurchaseOrderStatus status;
  final List<PurchaseOrderLine> lines;

  Supplier get supplier => MockData.supplierById(supplierId)!;

  double get total =>
      lines.fold<double>(0, (double s, PurchaseOrderLine l) => s + l.total);

  int get totalQuantity =>
      lines.fold<int>(0, (int s, PurchaseOrderLine l) => s + l.quantity);

  int get receivedQuantity => lines.fold<int>(
        0,
        (int s, PurchaseOrderLine l) => s + l.receivedQuantity,
      );

  /// نسبة الاستلام من 0 لـ1
  double get receivedRatio =>
      totalQuantity == 0 ? 0 : receivedQuantity / totalQuantity;

  bool get isReceivable =>
      status == PurchaseOrderStatus.confirmed ||
      status == PurchaseOrderStatus.partiallyReceived;
}

// ── الفواتير وكشوف الحساب ──────────────────────────────────────────────────

/// صنف داخل فاتورة بيع
class InvoiceLine {
  const InvoiceLine({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });

  final String productId;
  final int quantity;
  final double unitPrice;

  Product get product => MockData.productById(productId)!;
  double get total => quantity * unitPrice;
}

class SaleInvoice {
  const SaleInvoice({
    required this.id,
    required this.customerId,
    required this.date,
    required this.lines,
    required this.paymentMethod,
    required this.isPaid,
  });

  final String id;
  final String customerId;
  final DateTime date;
  final List<InvoiceLine> lines;
  final String paymentMethod;
  final bool isPaid;

  double get subtotal =>
      lines.fold<double>(0, (double s, InvoiceLine l) => s + l.total);

  double get tax => subtotal * MockData.taxRate;

  double get total => subtotal + tax;

  int get itemsCount => lines.length;

  Customer? get customer => MockData.customerById(customerId);
}

// ── الورديات ───────────────────────────────────────────────────────────────

/// ملخص وردية الكاشير الحالية
class ShiftSummary {
  const ShiftSummary({
    required this.id,
    required this.employeeId,
    required this.branchId,
    required this.startedAt,
    required this.openingBalance,
    required this.cashSales,
    required this.cardSales,
    required this.walletSales,
    required this.cashIn,
    required this.cashOut,
    required this.invoicesCount,
  });

  final String id;
  final String employeeId;
  final String branchId;
  final DateTime startedAt;
  final double openingBalance;
  final double cashSales;
  final double cardSales;
  final double walletSales;

  /// إيداعات نقدية أثناء الوردية
  final double cashIn;

  /// مسحوبات نقدية (مصروفات، توريد للخزنة)
  final double cashOut;
  final int invoicesCount;

  double get totalSales => cashSales + cardSales + walletSales;

  /// النقدية المفروض تكون في الدرج
  double get expectedCash => openingBalance + cashSales + cashIn - cashOut;

  Employee? get employee => MockData.employeeById(employeeId);
  Branch? get branch => MockData.branchById(branchId);
}

// ── العروض والخصومات ───────────────────────────────────────────────────────

enum PromotionType { percentage, buyXGetY, quantityDiscount }

extension PromotionTypeInfo on PromotionType {
  String get label => switch (this) {
        PromotionType.percentage => 'خصم نسبة',
        PromotionType.buyXGetY => 'اشترِ واحصل',
        PromotionType.quantityDiscount => 'خصم كمية',
      };

  IconData get icon => switch (this) {
        PromotionType.percentage => Icons.percent_rounded,
        PromotionType.buyXGetY => Icons.card_giftcard_rounded,
        PromotionType.quantityDiscount => Icons.inventory_2_rounded,
      };
}

enum PromotionStatus { active, scheduled, expired }

extension PromotionStatusInfo on PromotionStatus {
  String get label => switch (this) {
        PromotionStatus.active => 'نشط',
        PromotionStatus.scheduled => 'مجدول',
        PromotionStatus.expired => 'منتهي',
      };
}

class Promotion {
  const Promotion({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
    required this.scope,
    required this.startDate,
    required this.endDate,
    required this.usageCount,
  });

  final String id;
  final String name;
  final PromotionType type;

  /// نص جاهز للعرض: «15%» أو «2+1» أو «خصم 50 ج.م»
  final String value;

  /// على إيه بيتطبّق العرض
  final String scope;
  final DateTime startDate;
  final DateTime endDate;
  final int usageCount;

  PromotionStatus get status {
    final DateTime today = MockData.today;
    if (startDate.isAfter(today)) return PromotionStatus.scheduled;
    if (endDate.isBefore(today)) return PromotionStatus.expired;
    return PromotionStatus.active;
  }

  int get durationDays => endDate.difference(startDate).inDays;

  /// نسبة ما مضى من مدة العرض
  double get elapsedRatio {
    if (status == PromotionStatus.scheduled) return 0;
    if (status == PromotionStatus.expired) return 1;
    final int passed = MockData.today.difference(startDate).inDays;
    return durationDays == 0 ? 1 : (passed / durationDays).clamp(0, 1);
  }
}

// ── مستويات الولاء ─────────────────────────────────────────────────────────

class LoyaltyTierInfo {
  const LoyaltyTierInfo({
    required this.name,
    required this.minPoints,
    required this.benefits,
    required this.gradient,
    required this.icon,
  });

  final String name;
  final int minPoints;
  final List<String> benefits;
  final List<Color> gradient;
  final IconData icon;
}

enum LedgerType { sale, payment, purchase, refund, adjustment }

extension LedgerTypeInfo on LedgerType {
  String get label => switch (this) {
        LedgerType.sale => 'فاتورة بيع',
        LedgerType.payment => 'سداد',
        LedgerType.purchase => 'فاتورة شراء',
        LedgerType.refund => 'مرتجع',
        LedgerType.adjustment => 'تسوية',
      };

  IconData get icon => switch (this) {
        LedgerType.sale => Icons.receipt_long_rounded,
        LedgerType.payment => Icons.payments_rounded,
        LedgerType.purchase => Icons.local_shipping_rounded,
        LedgerType.refund => Icons.undo_rounded,
        LedgerType.adjustment => Icons.tune_rounded,
      };
}

/// حركة في كشف الحساب — موجب = عليه (مدين)، سالب = سداد/دائن
class LedgerEntry {
  const LedgerEntry({
    required this.id,
    required this.partyId,
    required this.date,
    required this.type,
    required this.description,
    required this.amount,
    required this.balanceAfter,
  });

  final String id;
  final String partyId;
  final DateTime date;
  final LedgerType type;
  final String description;
  final double amount;
  final double balanceAfter;

  bool get isDebit => amount >= 0;
}

enum LoyaltyType { earn, redeem }

class LoyaltyEntry {
  const LoyaltyEntry({
    required this.id,
    required this.customerId,
    required this.date,
    required this.type,
    required this.points,
    required this.note,
  });

  final String id;
  final String customerId;
  final DateTime date;
  final LoyaltyType type;
  final int points;
  final String note;
}

// ── الأدوار والصلاحيات ─────────────────────────────────────────────────────

class Role {
  const Role({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.employeesCount,
  });

  final String id;
  final String name;
  final String description;
  final IconData icon;
  final int employeesCount;
}

class Permission {
  const Permission({
    required this.id,
    required this.label,
    required this.description,
  });

  final String id;
  final String label;
  final String description;
}

class PermissionGroup {
  const PermissionGroup({
    required this.title,
    required this.icon,
    required this.permissions,
  });

  final String title;
  final IconData icon;
  final List<Permission> permissions;
}

/// رصيد منتج معيّن داخل فرع/مخزن معيّن.
class StockRecord {
  const StockRecord({
    required this.productId,
    required this.branchId,
    required this.onHand,
    required this.reserved,
    required this.lastMovement,
  });

  final String productId;
  final String branchId;

  /// الكمية الفعلية على الرف
  final int onHand;

  /// كمية محجوزة لطلبات لسه ماتسلمتش
  final int reserved;
  final DateTime lastMovement;

  /// المتاح للبيع فعليًا
  int get available => (onHand - reserved).clamp(0, onHand);

  Product get product => MockData.productById(productId)!;
  Branch get branch => MockData.branchById(branchId)!;

  double get value => product.cost * onHand;
}

// ═══════════════════════════════════════════════════════════════════════════
// Data
// ═══════════════════════════════════════════════════════════════════════════

class MockData {
  const MockData._();

  // ── الفروع ───────────────────────────────────────────────────────────────
  static const List<Branch> branches = <Branch>[
    Branch(
      id: 'br-1',
      name: 'الفرع الرئيسي — المعادي',
      address: 'شارع 9، المعادي، القاهرة',
      phone: '02-25230011',
      isMain: true,
      monthSales: 486320.00,
      managerName: 'محمد صلاح',
      isOpen: true,
      openingHours: '9:00 ص — 11:00 م',
    ),
    Branch(
      id: 'br-2',
      name: 'فرع مدينة نصر',
      address: 'عباس العقاد، مدينة نصر، القاهرة',
      phone: '02-22710044',
      isMain: false,
      monthSales: 312750.50,
      managerName: 'عمرو الشناوي',
      isOpen: true,
      openingHours: '10:00 ص — 12:00 م',
    ),
    Branch(
      id: 'br-3',
      name: 'فرع الإسكندرية',
      address: 'سموحة، الإسكندرية',
      phone: '03-4270099',
      isMain: false,
      monthSales: 198430.25,
      managerName: 'ياسمين طارق',
      isOpen: false,
      openingHours: '10:00 ص — 10:00 م',
    ),
  ];

  // ── الفئات ───────────────────────────────────────────────────────────────
  static const List<ProductCategory> categories = <ProductCategory>[
    ProductCategory(
      id: 'cat-grocery',
      name: 'بقالة',
      icon: Icons.shopping_basket_outlined,
    ),
    ProductCategory(
      id: 'cat-drinks',
      name: 'مشروبات',
      icon: Icons.local_cafe_outlined,
    ),
    ProductCategory(
      id: 'cat-dairy',
      name: 'ألبان وأجبان',
      icon: Icons.egg_alt_outlined,
    ),
    ProductCategory(
      id: 'cat-snacks',
      name: 'سناكس وحلويات',
      icon: Icons.cookie_outlined,
    ),
    ProductCategory(
      id: 'cat-pharmacy',
      name: 'أدوية',
      icon: Icons.medical_services_outlined,
    ),
    ProductCategory(
      id: 'cat-care',
      name: 'عناية شخصية',
      icon: Icons.spa_outlined,
    ),
    ProductCategory(
      id: 'cat-clothes',
      name: 'ملابس',
      icon: Icons.checkroom_outlined,
    ),
    ProductCategory(
      id: 'cat-electronics',
      name: 'إلكترونيات',
      icon: Icons.devices_other_outlined,
    ),
  ];

  // ── المنتجات ─────────────────────────────────────────────────────────────
  static const List<Product> products = <Product>[
    // بقالة
    Product(
      id: 'p-1001',
      name: 'أرز مصري فاخر 1 كجم',
      sku: 'GRC-1001',
      barcode: '6221031001012',
      categoryId: 'cat-grocery',
      price: 42.50,
      cost: 33.00,
      stock: 184,
      minStock: 40,
      unit: 'كيس',
      colorIndex: 2,
    ),
    Product(
      id: 'p-1002',
      name: 'زيت عباد الشمس 1.5 لتر',
      sku: 'GRC-1002',
      barcode: '6221031001029',
      categoryId: 'cat-grocery',
      price: 118.00,
      cost: 96.00,
      stock: 62,
      minStock: 25,
      unit: 'زجاجة',
      colorIndex: 3,
    ),
    Product(
      id: 'p-1003',
      name: 'سكر أبيض ناعم 1 كجم',
      sku: 'GRC-1003',
      barcode: '6221031001036',
      categoryId: 'cat-grocery',
      price: 36.00,
      cost: 29.50,
      stock: 18,
      minStock: 30,
      unit: 'كيس',
      colorIndex: 0,
    ),
    Product(
      id: 'p-1004',
      name: 'مكرونة إسباجيتي 400 جم',
      sku: 'GRC-1004',
      barcode: '6221031001043',
      categoryId: 'cat-grocery',
      price: 19.75,
      cost: 14.00,
      stock: 240,
      minStock: 50,
      unit: 'باكو',
      colorIndex: 5,
    ),
    Product(
      id: 'p-1005',
      name: 'شاي أسود فاخر 250 جم',
      sku: 'GRC-1005',
      barcode: '6221031001050',
      categoryId: 'cat-grocery',
      price: 89.00,
      cost: 71.00,
      stock: 47,
      minStock: 20,
      unit: 'علبة',
      colorIndex: 7,
    ),
    Product(
      id: 'p-1006',
      name: 'ملح طعام معالج 1 كجم',
      sku: 'GRC-1006',
      barcode: '6221031001067',
      categoryId: 'cat-grocery',
      price: 8.50,
      cost: 5.75,
      stock: 310,
      minStock: 60,
      unit: 'كيس',
      colorIndex: 1,
      brand: 'الملكة',
      isActive: false,
    ),

    // مشروبات
    Product(
      id: 'p-2001',
      name: 'مياه معدنية 1.5 لتر',
      sku: 'DRK-2001',
      barcode: '6221032002011',
      categoryId: 'cat-drinks',
      price: 12.00,
      cost: 8.00,
      stock: 420,
      minStock: 100,
      unit: 'زجاجة',
      colorIndex: 1,
    ),
    Product(
      id: 'p-2002',
      name: 'مشروب غازي كولا 1 لتر',
      sku: 'DRK-2002',
      barcode: '6221032002028',
      categoryId: 'cat-drinks',
      price: 28.00,
      cost: 21.50,
      stock: 156,
      minStock: 50,
      unit: 'زجاجة',
      colorIndex: 4,
    ),
    Product(
      id: 'p-2003',
      name: 'عصير برتقال طبيعي 1 لتر',
      sku: 'DRK-2003',
      barcode: '6221032002035',
      categoryId: 'cat-drinks',
      price: 46.00,
      cost: 35.00,
      stock: 8,
      minStock: 20,
      unit: 'كرتونة',
      colorIndex: 3,
    ),
    Product(
      id: 'p-2004',
      name: 'قهوة تركي محوجة 200 جم',
      sku: 'DRK-2004',
      barcode: '6221032002042',
      categoryId: 'cat-drinks',
      price: 135.00,
      cost: 108.00,
      stock: 34,
      minStock: 15,
      unit: 'علبة',
      colorIndex: 7,
    ),
    Product(
      id: 'p-2005',
      name: 'مشروب طاقة 250 مل',
      sku: 'DRK-2005',
      barcode: '6221032002059',
      categoryId: 'cat-drinks',
      price: 38.00,
      cost: 29.00,
      stock: 92,
      minStock: 30,
      unit: 'علبة',
      colorIndex: 5,
    ),

    // ألبان وأجبان
    Product(
      id: 'p-3001',
      name: 'لبن كامل الدسم 1 لتر',
      sku: 'DRY-3001',
      barcode: '6221033003013',
      categoryId: 'cat-dairy',
      price: 44.00,
      cost: 36.50,
      stock: 76,
      minStock: 30,
      unit: 'كرتونة',
      colorIndex: 1,
    ),
    Product(
      id: 'p-3002',
      name: 'جبنة بيضاء 500 جم',
      sku: 'DRY-3002',
      barcode: '6221033003020',
      categoryId: 'cat-dairy',
      price: 68.00,
      cost: 54.00,
      stock: 41,
      minStock: 20,
      unit: 'علبة',
      colorIndex: 6,
    ),
    Product(
      id: 'p-3003',
      name: 'زبادي طبيعي 105 جم',
      sku: 'DRY-3003',
      barcode: '6221033003037',
      categoryId: 'cat-dairy',
      price: 9.50,
      cost: 7.00,
      stock: 0,
      minStock: 40,
      unit: 'عبوة',
      colorIndex: 2,
    ),
    Product(
      id: 'p-3004',
      name: 'جبنة رومي مبشورة 250 جم',
      sku: 'DRY-3004',
      barcode: '6221033003044',
      categoryId: 'cat-dairy',
      price: 96.00,
      cost: 78.00,
      stock: 23,
      minStock: 15,
      unit: 'علبة',
      colorIndex: 3,
    ),

    // سناكس وحلويات
    Product(
      id: 'p-4001',
      name: 'شيبسي ملح 90 جم',
      sku: 'SNK-4001',
      barcode: '6221034004014',
      categoryId: 'cat-snacks',
      price: 15.00,
      cost: 10.50,
      stock: 268,
      minStock: 60,
      unit: 'كيس',
      colorIndex: 3,
    ),
    Product(
      id: 'p-4002',
      name: 'شوكولاتة بالحليب 80 جم',
      sku: 'SNK-4002',
      barcode: '6221034004021',
      categoryId: 'cat-snacks',
      price: 34.00,
      cost: 25.00,
      stock: 143,
      minStock: 40,
      unit: 'قطعة',
      colorIndex: 7,
    ),
    Product(
      id: 'p-4003',
      name: 'بسكويت ساندويتش 12 قطعة',
      sku: 'SNK-4003',
      barcode: '6221034004038',
      categoryId: 'cat-snacks',
      price: 52.00,
      cost: 40.00,
      stock: 87,
      minStock: 25,
      unit: 'باكو',
      colorIndex: 4,
    ),
    Product(
      id: 'p-4004',
      name: 'مكسرات مشكلة 300 جم',
      sku: 'SNK-4004',
      barcode: '6221034004045',
      categoryId: 'cat-snacks',
      price: 185.00,
      cost: 148.00,
      stock: 12,
      minStock: 15,
      unit: 'علبة',
      colorIndex: 5,
    ),

    // أدوية
    Product(
      id: 'p-5001',
      name: 'باراسيتامول 500 مجم — 20 قرص',
      sku: 'PHR-5001',
      barcode: '6221035005015',
      categoryId: 'cat-pharmacy',
      price: 24.00,
      cost: 17.50,
      stock: 130,
      minStock: 40,
      unit: 'شريط',
      colorIndex: 0,
    ),
    Product(
      id: 'p-5002',
      name: 'فيتامين سي 1000 مجم — 20 قرص فوار',
      sku: 'PHR-5002',
      barcode: '6221035005022',
      categoryId: 'cat-pharmacy',
      price: 78.00,
      cost: 60.00,
      stock: 54,
      minStock: 20,
      unit: 'علبة',
      colorIndex: 3,
    ),
    Product(
      id: 'p-5003',
      name: 'كحول طبي 70% — 250 مل',
      sku: 'PHR-5003',
      barcode: '6221035005039',
      categoryId: 'cat-pharmacy',
      price: 32.00,
      cost: 23.00,
      stock: 9,
      minStock: 25,
      unit: 'زجاجة',
      colorIndex: 1,
    ),
    Product(
      id: 'p-5004',
      name: 'شاش طبي معقم 10×10',
      sku: 'PHR-5004',
      barcode: '6221035005046',
      categoryId: 'cat-pharmacy',
      price: 18.50,
      cost: 12.00,
      stock: 176,
      minStock: 50,
      unit: 'عبوة',
      colorIndex: 6,
    ),

    // عناية شخصية
    Product(
      id: 'p-6001',
      name: 'شامبو للشعر الجاف 400 مل',
      sku: 'CRE-6001',
      barcode: '6221036006016',
      categoryId: 'cat-care',
      price: 145.00,
      cost: 112.00,
      stock: 38,
      minStock: 15,
      unit: 'زجاجة',
      colorIndex: 5,
    ),
    Product(
      id: 'p-6002',
      name: 'معجون أسنان 100 مل',
      sku: 'CRE-6002',
      barcode: '6221036006023',
      categoryId: 'cat-care',
      price: 58.00,
      cost: 44.00,
      stock: 94,
      minStock: 30,
      unit: 'أنبوبة',
      colorIndex: 1,
    ),
    Product(
      id: 'p-6003',
      name: 'صابون سائل لليدين 500 مل',
      sku: 'CRE-6003',
      barcode: '6221036006030',
      categoryId: 'cat-care',
      price: 72.00,
      cost: 55.00,
      stock: 61,
      minStock: 20,
      unit: 'زجاجة',
      colorIndex: 2,
    ),

    // ملابس
    Product(
      id: 'p-7001',
      name: 'تي شيرت قطن رجالي — مقاس L',
      sku: 'CLO-7001',
      barcode: '6221037007017',
      categoryId: 'cat-clothes',
      price: 385.00,
      cost: 240.00,
      stock: 27,
      minStock: 10,
      unit: 'قطعة',
      colorIndex: 0,
    ),
    Product(
      id: 'p-7002',
      name: 'بنطلون جينز رجالي — مقاس 32',
      sku: 'CLO-7002',
      barcode: '6221037007024',
      categoryId: 'cat-clothes',
      price: 890.00,
      cost: 580.00,
      stock: 14,
      minStock: 8,
      unit: 'قطعة',
      colorIndex: 1,
    ),
    Product(
      id: 'p-7003',
      name: 'فستان صيفي حريمي — مقاس M',
      sku: 'CLO-7003',
      barcode: '6221037007031',
      categoryId: 'cat-clothes',
      price: 720.00,
      cost: 450.00,
      stock: 6,
      minStock: 8,
      unit: 'قطعة',
      colorIndex: 4,
      brand: 'زارا ستايل',
      isActive: false,
    ),
    Product(
      id: 'p-7004',
      name: 'جاكيت شتوي — مقاس XL',
      sku: 'CLO-7004',
      barcode: '6221037007048',
      categoryId: 'cat-clothes',
      price: 1450.00,
      cost: 980.00,
      stock: 11,
      minStock: 5,
      unit: 'قطعة',
      colorIndex: 6,
    ),

    // إلكترونيات
    Product(
      id: 'p-8001',
      name: 'سماعة بلوتوث لاسلكية',
      sku: 'ELC-8001',
      barcode: '6221038008018',
      categoryId: 'cat-electronics',
      price: 1250.00,
      cost: 890.00,
      stock: 19,
      minStock: 8,
      unit: 'قطعة',
      colorIndex: 5,
    ),
    Product(
      id: 'p-8002',
      name: 'شاحن سريع 33 وات USB-C',
      sku: 'ELC-8002',
      barcode: '6221038008025',
      categoryId: 'cat-electronics',
      price: 480.00,
      cost: 320.00,
      stock: 43,
      minStock: 15,
      unit: 'قطعة',
      colorIndex: 0,
    ),
    Product(
      id: 'p-8003',
      name: 'باور بانك 10000 مللي أمبير',
      sku: 'ELC-8003',
      barcode: '6221038008032',
      categoryId: 'cat-electronics',
      price: 950.00,
      cost: 690.00,
      stock: 3,
      minStock: 10,
      unit: 'قطعة',
      colorIndex: 7,
      brand: 'أنكر',
      isActive: false,
    ),
    Product(
      id: 'p-8004',
      name: 'كابل شحن مضفر 1 متر',
      sku: 'ELC-8004',
      barcode: '6221038008049',
      categoryId: 'cat-electronics',
      price: 165.00,
      cost: 98.00,
      stock: 128,
      minStock: 40,
      unit: 'قطعة',
      colorIndex: 2,
    ),
  ];

  // ── العملاء ──────────────────────────────────────────────────────────────
  static final List<Customer> customers = <Customer>[
    Customer(
      id: 'c-0',
      name: 'عميل نقدي',
      phone: '—',
      email: '—',
      tier: CustomerTier.regular,
      balance: 0,
      points: 0,
      totalPurchases: 0,
      ordersCount: 0,
      lastVisit: DateTime(2026, 8, 13),
    ),
    Customer(
      id: 'c-1',
      name: 'أحمد عبد الرحمن',
      phone: '0100 234 5678',
      email: 'ahmed.abdelrahman@mail.com',
      tier: CustomerTier.gold,
      balance: -1250.00,
      points: 3420,
      totalPurchases: 84630.50,
      ordersCount: 96,
      lastVisit: DateTime(2026, 8, 12),
    ),
    Customer(
      id: 'c-2',
      name: 'منى السيد',
      phone: '0111 887 2210',
      email: 'mona.elsayed@mail.com',
      tier: CustomerTier.silver,
      balance: 0,
      points: 1180,
      totalPurchases: 31240.00,
      ordersCount: 48,
      lastVisit: DateTime(2026, 8, 11),
    ),
    Customer(
      id: 'c-3',
      name: 'شركة النيل للتوريدات',
      phone: '02 2519 8800',
      email: 'orders@nile-supplies.com',
      tier: CustomerTier.gold,
      balance: -18400.00,
      points: 9650,
      totalPurchases: 412700.00,
      ordersCount: 134,
      lastVisit: DateTime(2026, 8, 13),
    ),
    Customer(
      id: 'c-4',
      name: 'كريم مصطفى',
      phone: '0122 445 9931',
      email: 'karim.mostafa@mail.com',
      tier: CustomerTier.regular,
      balance: 350.00,
      points: 420,
      totalPurchases: 9870.25,
      ordersCount: 21,
      lastVisit: DateTime(2026, 8, 9),
    ),
    Customer(
      id: 'c-5',
      name: 'صيدلية الشفاء',
      phone: '02 2764 3321',
      email: 'info@shefaa-pharmacy.com',
      tier: CustomerTier.silver,
      balance: -4600.00,
      points: 2870,
      totalPurchases: 156300.00,
      ordersCount: 77,
      lastVisit: DateTime(2026, 8, 10),
    ),
    Customer(
      id: 'c-6',
      name: 'هدى إبراهيم',
      phone: '0155 302 7744',
      email: 'hoda.ibrahim@mail.com',
      tier: CustomerTier.regular,
      balance: 0,
      points: 260,
      totalPurchases: 5410.00,
      ordersCount: 14,
      lastVisit: DateTime(2026, 8, 6),
    ),
    Customer(
      id: 'c-7',
      name: 'محمود فتحي',
      phone: '0106 118 4402',
      email: 'mahmoud.fathy@mail.com',
      tier: CustomerTier.silver,
      balance: -820.00,
      points: 1540,
      totalPurchases: 42980.75,
      ordersCount: 59,
      lastVisit: DateTime(2026, 8, 12),
    ),
  ];

  /// العميل الافتراضي في شاشة نقطة البيع
  static Customer get walkInCustomer => customers.first;

  // ── الموردين ─────────────────────────────────────────────────────────────
  static const List<Supplier> suppliers = <Supplier>[
    Supplier(
      id: 's-1',
      name: 'شركة الدلتا للأغذية',
      contactPerson: 'سامح عبد اللطيف',
      phone: '02 2408 7711',
      email: 'sales@delta-foods.com',
      balanceDue: 62400.00,
      totalPurchases: 986500.00,
      ordersCount: 148,
      isActive: true,
    ),
    Supplier(
      id: 's-2',
      name: 'الشرق الأوسط للمشروبات',
      contactPerson: 'ياسر النجار',
      phone: '02 2690 1122',
      email: 'purchase@me-beverages.com',
      balanceDue: 18750.50,
      totalPurchases: 543200.00,
      ordersCount: 92,
      isActive: true,
    ),
    Supplier(
      id: 's-3',
      name: 'فارما بلس للأدوية',
      contactPerson: 'د. رانيا شاكر',
      phone: '02 2733 5566',
      email: 'orders@pharmaplus.com',
      balanceDue: 0,
      totalPurchases: 371900.00,
      ordersCount: 64,
      isActive: true,
    ),
    Supplier(
      id: 's-4',
      name: 'النور للملابس الجاهزة',
      contactPerson: 'عصام بدر',
      phone: '03 5820 4433',
      email: 'info@alnour-textiles.com',
      balanceDue: 94300.00,
      totalPurchases: 728400.00,
      ordersCount: 51,
      isActive: true,
    ),
    Supplier(
      id: 's-5',
      name: 'تك لاين للإلكترونيات',
      contactPerson: 'مصطفى حلمي',
      phone: '02 2591 8877',
      email: 'b2b@techline-eg.com',
      balanceDue: 31200.00,
      totalPurchases: 1204600.00,
      ordersCount: 38,
      isActive: false,
    ),
  ];

  // ── الموظفين ─────────────────────────────────────────────────────────────
  static final List<Employee> employees = <Employee>[
    Employee(
      id: 'e-1',
      name: 'محمد صلاح',
      role: 'مدير النظام',
      branchId: 'br-1',
      phone: '0100 555 1122',
      salary: 18000,
      hiredAt: DateTime(2023, 3, 12),
      isActive: true,
      todaySales: 0,
      roleId: 'role-admin',
      lastLogin: DateTime(2026, 8, 13, 8, 42),
    ),
    Employee(
      id: 'e-2',
      name: 'سارة عادل',
      role: 'كاشير',
      branchId: 'br-1',
      phone: '0111 220 8844',
      salary: 8500,
      hiredAt: DateTime(2024, 7, 1),
      isActive: true,
      todaySales: 24380.50,
      roleId: 'role-cashier',
      lastLogin: DateTime(2026, 8, 13, 9, 12),
    ),
    Employee(
      id: 'e-3',
      name: 'خالد رمضان',
      role: 'مسؤول مخزن',
      branchId: 'br-1',
      phone: '0122 903 4471',
      salary: 9200,
      hiredAt: DateTime(2024, 1, 20),
      isActive: true,
      todaySales: 0,
      roleId: 'role-manager',
      lastLogin: DateTime(2026, 8, 12, 17, 5),
    ),
    Employee(
      id: 'e-4',
      name: 'نورهان مجدي',
      role: 'كاشير',
      branchId: 'br-2',
      phone: '0106 774 2039',
      salary: 8500,
      hiredAt: DateTime(2025, 2, 9),
      isActive: true,
      todaySales: 17920.00,
      roleId: 'role-cashier',
      lastLogin: DateTime(2026, 8, 13, 10, 3),
    ),
    Employee(
      id: 'e-5',
      name: 'عمرو الشناوي',
      role: 'مدير فرع',
      branchId: 'br-2',
      phone: '0155 641 7788',
      salary: 14000,
      hiredAt: DateTime(2023, 11, 5),
      isActive: true,
      todaySales: 6110.25,
      roleId: 'role-manager',
      lastLogin: DateTime(2026, 8, 13, 8, 55),
    ),
    Employee(
      id: 'e-6',
      name: 'ياسمين طارق',
      role: 'محاسب',
      branchId: 'br-3',
      phone: '0100 318 9922',
      salary: 12500,
      hiredAt: DateTime(2025, 6, 15),
      isActive: false,
      todaySales: 0,
      roleId: 'role-accountant',
      lastLogin: DateTime(2026, 7, 28, 14, 20),
    ),
  ];

  /// المستخدم اللي فاتح النظام دلوقتي (بيظهر في الـTop Bar)
  static Employee get currentUser => employees.first;

  /// الفرع النشط حاليًا
  static Branch get currentBranch => branches.first;

  static const int unreadNotifications = 5;

  /// اليوم الحالي في النظام (ثابت عشان البيانات تفضل متّسقة)
  static DateTime get today => DateTime(2026, 8, 13);

  // ── الأدوار والصلاحيات ───────────────────────────────────────────────────
  static const List<Role> roles = <Role>[
    Role(
      id: 'role-cashier',
      name: 'كاشير',
      description: 'تشغيل نقطة البيع وإصدار الفواتير',
      icon: Icons.point_of_sale_rounded,
      employeesCount: 2,
    ),
    Role(
      id: 'role-manager',
      name: 'مدير فرع',
      description: 'إدارة فرع واحد ومخزونه وموظفيه',
      icon: Icons.store_rounded,
      employeesCount: 2,
    ),
    Role(
      id: 'role-accountant',
      name: 'محاسب',
      description: 'المالية والتقارير وكشوف الحسابات',
      icon: Icons.calculate_rounded,
      employeesCount: 1,
    ),
    Role(
      id: 'role-admin',
      name: 'مدير عام',
      description: 'صلاحيات كاملة على كل الفروع والإعدادات',
      icon: Icons.admin_panel_settings_rounded,
      employeesCount: 1,
    ),
  ];

  static const List<PermissionGroup> permissionGroups = <PermissionGroup>[
    PermissionGroup(
      title: 'المبيعات',
      icon: Icons.point_of_sale_rounded,
      permissions: <Permission>[
        Permission(
          id: 'sales.pos',
          label: 'يمكنه فتح شاشة نقطة البيع',
          description: 'الدخول للكاشير وتسجيل الفواتير',
        ),
        Permission(
          id: 'sales.discount',
          label: 'يمكنه تطبيق خصم',
          description: 'خصم يدوي على الفاتورة أو الصنف',
        ),
        Permission(
          id: 'sales.void',
          label: 'يمكنه إلغاء فاتورة',
          description: 'إلغاء فاتورة بعد إصدارها',
        ),
        Permission(
          id: 'sales.credit',
          label: 'يمكنه البيع الآجل',
          description: 'تسجيل المبيعات على حساب العميل',
        ),
        Permission(
          id: 'sales.refund',
          label: 'يمكنه عمل مرتجعات',
          description: 'إرجاع أصناف واسترداد المبالغ',
        ),
      ],
    ),
    PermissionGroup(
      title: 'المخزون',
      icon: Icons.warehouse_rounded,
      permissions: <Permission>[
        Permission(
          id: 'stock.view',
          label: 'يمكنه عرض المخزون',
          description: 'الاطلاع على الأرصدة في كل الفروع',
        ),
        Permission(
          id: 'stock.products',
          label: 'يمكنه إدارة المنتجات',
          description: 'إضافة وتعديل وحذف المنتجات',
        ),
        Permission(
          id: 'stock.adjust',
          label: 'يمكنه تعديل الكميات يدويًا',
          description: 'تسويات المخزون المباشرة',
        ),
        Permission(
          id: 'stock.transfer',
          label: 'يمكنه تحويل مخزون بين الفروع',
          description: 'إنشاء أوامر تحويل واستلامها',
        ),
        Permission(
          id: 'stock.stocktake',
          label: 'يمكنه بدء واعتماد الجرد',
          description: 'تنفيذ الجرد وترحيل الفروقات',
        ),
      ],
    ),
    PermissionGroup(
      title: 'المشتريات',
      icon: Icons.shopping_cart_rounded,
      permissions: <Permission>[
        Permission(
          id: 'purchase.view',
          label: 'يمكنه عرض أوامر الشراء',
          description: 'الاطلاع على أوامر الشراء وحالتها',
        ),
        Permission(
          id: 'purchase.create',
          label: 'يمكنه إنشاء أمر شراء',
          description: 'تجهيز أوامر شراء جديدة كمسودة',
        ),
        Permission(
          id: 'purchase.approve',
          label: 'يمكنه اعتماد أمر شراء',
          description: 'تأكيد الأمر وإرساله للمورد',
        ),
        Permission(
          id: 'purchase.receive',
          label: 'يمكنه استلام البضاعة',
          description: 'الاستلام الكلي أو الجزئي',
        ),
        Permission(
          id: 'purchase.suppliers',
          label: 'يمكنه إدارة الموردين',
          description: 'إضافة وتعديل بيانات الموردين',
        ),
      ],
    ),
    PermissionGroup(
      title: 'المالية',
      icon: Icons.account_balance_wallet_rounded,
      permissions: <Permission>[
        Permission(
          id: 'finance.reports',
          label: 'يمكنه عرض التقارير المالية',
          description: 'تقارير المبيعات والأرباح',
        ),
        Permission(
          id: 'finance.profit',
          label: 'يمكنه رؤية هوامش الربح والتكلفة',
          description: 'أسعار الشراء وصافي الربح',
        ),
        Permission(
          id: 'finance.expenses',
          label: 'يمكنه تسجيل المصروفات',
          description: 'إضافة واعتماد المصروفات',
        ),
        Permission(
          id: 'finance.cashbox',
          label: 'يمكنه إدارة الخزينة',
          description: 'فتح وإغلاق الورديات والعُهد',
        ),
        Permission(
          id: 'finance.collect',
          label: 'يمكنه تحصيل المديونيات',
          description: 'تسجيل سداد العملاء والموردين',
        ),
      ],
    ),
    PermissionGroup(
      title: 'الإدارة',
      icon: Icons.settings_rounded,
      permissions: <Permission>[
        Permission(
          id: 'admin.employees',
          label: 'يمكنه إدارة الموظفين',
          description: 'إضافة موظفين وتعديل بياناتهم',
        ),
        Permission(
          id: 'admin.roles',
          label: 'يمكنه تعديل الأدوار والصلاحيات',
          description: 'التحكم في صلاحيات باقي المستخدمين',
        ),
        Permission(
          id: 'admin.branches',
          label: 'يمكنه إدارة الفروع',
          description: 'إضافة فروع ومخازن جديدة',
        ),
        Permission(
          id: 'admin.settings',
          label: 'يمكنه تغيير إعدادات النظام',
          description: 'الضرائب والعملة وشكل الفاتورة',
        ),
        Permission(
          id: 'admin.export',
          label: 'يمكنه تصدير البيانات',
          description: 'تصدير التقارير وقواعد البيانات',
        ),
      ],
    ),
  ];

  /// الصلاحيات المفعّلة افتراضيًا لكل دور
  static final Map<String, Set<String>> rolePermissions = <String, Set<String>>{
    'role-cashier': <String>{
      'sales.pos',
      'sales.credit',
      'stock.view',
      'purchase.view',
    },
    'role-manager': <String>{
      'sales.pos',
      'sales.discount',
      'sales.void',
      'sales.credit',
      'sales.refund',
      'stock.view',
      'stock.products',
      'stock.adjust',
      'stock.transfer',
      'stock.stocktake',
      'purchase.view',
      'purchase.create',
      'purchase.receive',
      'finance.reports',
      'finance.cashbox',
      'admin.employees',
    },
    'role-accountant': <String>{
      'stock.view',
      'purchase.view',
      'purchase.approve',
      'purchase.suppliers',
      'finance.reports',
      'finance.profit',
      'finance.expenses',
      'finance.cashbox',
      'finance.collect',
      'admin.export',
    },
    'role-admin': <String>{
      for (final PermissionGroup g in permissionGroups)
        for (final Permission p in g.permissions) p.id,
    },
  };

  // ── أوامر الشراء ─────────────────────────────────────────────────────────
  static final List<PurchaseOrder> purchaseOrders = <PurchaseOrder>[
    _po('PO-1058', 's-1', 1, 6, PurchaseOrderStatus.draft, <(String, int, int)>[
      ('p-1001', 120, 0),
      ('p-1004', 200, 0),
      ('p-1005', 60, 0),
    ]),
    _po('PO-1057', 's-2', 2, 4, PurchaseOrderStatus.confirmed,
        <(String, int, int)>[
          ('p-2001', 400, 0),
          ('p-2002', 180, 0),
          ('p-2005', 100, 0),
        ]),
    _po('PO-1056', 's-3', 3, 5, PurchaseOrderStatus.confirmed,
        <(String, int, int)>[
          ('p-5001', 150, 0),
          ('p-5003', 80, 0),
        ]),
    _po('PO-1055', 's-1', 5, 2, PurchaseOrderStatus.partiallyReceived,
        <(String, int, int)>[
          ('p-3001', 90, 60),
          ('p-3002', 50, 50),
          ('p-3003', 120, 0),
        ]),
    _po('PO-1054', 's-4', 8, 14, PurchaseOrderStatus.partiallyReceived,
        <(String, int, int)>[
          ('p-7001', 40, 25),
          ('p-7002', 20, 20),
          ('p-7004', 15, 0),
        ]),
    _po('PO-1053', 's-5', 11, 3, PurchaseOrderStatus.completed,
        <(String, int, int)>[
          ('p-8002', 60, 60),
          ('p-8004', 150, 150),
        ]),
    _po('PO-1052', 's-2', 15, 5, PurchaseOrderStatus.completed,
        <(String, int, int)>[
          ('p-2003', 80, 80),
          ('p-2004', 40, 40),
        ]),
    _po('PO-1051', 's-3', 19, 6, PurchaseOrderStatus.completed,
        <(String, int, int)>[
          ('p-5002', 70, 70),
          ('p-5004', 200, 200),
          ('p-6002', 110, 110),
        ]),
    _po('PO-1050', 's-1', 24, 7, PurchaseOrderStatus.completed,
        <(String, int, int)>[
          ('p-1002', 80, 80),
          ('p-1003', 100, 100),
        ]),
    _po('PO-1049', 's-5', 31, 9, PurchaseOrderStatus.draft,
        <(String, int, int)>[
          ('p-8001', 25, 0),
        ]),
  ];

  static PurchaseOrder _po(
    String id,
    String supplierId,
    int daysAgo,
    int leadDays,
    PurchaseOrderStatus status,
    List<(String, int, int)> items,
  ) {
    final DateTime date = today.subtract(Duration(days: daysAgo));
    return PurchaseOrder(
      id: id,
      supplierId: supplierId,
      date: date,
      expectedDate: date.add(Duration(days: leadDays)),
      status: status,
      lines: <PurchaseOrderLine>[
        for (final (String productId, int qty, int received) item in items)
          PurchaseOrderLine(
            productId: item.$1,
            quantity: item.$2,
            receivedQuantity: item.$3,
            unitCost: productById(item.$1)!.cost,
          ),
      ],
    );
  }

  // ── فواتير البيع ─────────────────────────────────────────────────────────
  static final List<SaleInvoice> salesInvoices = _buildInvoices();

  static List<SaleInvoice> _buildInvoices() {
    final List<SaleInvoice> list = <SaleInvoice>[];
    int number = 2480;

    for (final Customer c in customers) {
      if (c.id == walkInCustomer.id) continue;
      final int seed = _seedOf(c.id);

      for (int i = 0; i < 6; i++) {
        final int step = ((seed >> (i * 2)) % 11) + 2;
        final bool credit = (seed + i) % 4 == 0;

        list.add(
          SaleInvoice(
            id: 'INV-${number--}',
            customerId: c.id,
            date: c.lastVisit.subtract(Duration(days: i * step)),
            lines: _invoiceLines(seed + i * 13),
            paymentMethod: credit
                ? 'آجل'
                : <String>['نقدي', 'بطاقة', 'محفظة'][(seed + i) % 3],
            isPaid: !credit,
          ),
        );
      }
    }

    list.sort((SaleInvoice a, SaleInvoice b) => b.date.compareTo(a.date));
    return list;
  }

  /// أصناف فاتورة مشتقّة من رقم ثابت — نفس الفاتورة بتديك نفس الأصناف دايمًا
  static List<InvoiceLine> _invoiceLines(int seed) {
    final int count = (seed % 5) + 2;
    final List<InvoiceLine> lines = <InvoiceLine>[];
    final Set<String> used = <String>{};

    for (int i = 0; i < count; i++) {
      final Product p = products[(seed + i * 7) % products.length];
      if (!used.add(p.id)) continue;
      lines.add(
        InvoiceLine(
          productId: p.id,
          quantity: ((seed >> (i + 1)) % 3) + 1,
          unitPrice: p.price,
        ),
      );
    }
    return lines;
  }

  static SaleInvoice? invoiceById(String id) {
    for (final SaleInvoice i in salesInvoices) {
      if (i.id.toLowerCase() == id.toLowerCase()) return i;
    }
    return null;
  }

  static List<SaleInvoice> invoicesForCustomer(String customerId) =>
      salesInvoices
          .where((SaleInvoice i) => i.customerId == customerId)
          .toList(growable: false);

  // ── كشوف الحسابات ────────────────────────────────────────────────────────
  static final List<LedgerEntry> ledgerEntries = _buildLedger();

  static List<LedgerEntry> _buildLedger() {
    final List<LedgerEntry> list = <LedgerEntry>[];
    int number = 900;

    // العملاء: فواتير + سداد
    for (final Customer c in customers) {
      if (c.id == walkInCustomer.id) continue;
      double balance = 0;
      final List<SaleInvoice> invoices =
          invoicesForCustomer(c.id).reversed.toList();

      for (int i = 0; i < invoices.length; i++) {
        final SaleInvoice inv = invoices[i];
        balance += inv.total;
        list.add(
          LedgerEntry(
            id: 'LG-${number++}',
            partyId: c.id,
            date: inv.date,
            type: LedgerType.sale,
            description: 'فاتورة رقم ${inv.id} — ${inv.itemsCount} صنف',
            amount: inv.total,
            balanceAfter: balance,
          ),
        );

        if (inv.isPaid) {
          balance -= inv.total;
          list.add(
            LedgerEntry(
              id: 'LG-${number++}',
              partyId: c.id,
              date: inv.date.add(const Duration(hours: 1)),
              type: LedgerType.payment,
              description: 'سداد ${inv.paymentMethod} لفاتورة ${inv.id}',
              amount: -inv.total,
              balanceAfter: balance,
            ),
          );
        }
      }
    }

    // الموردين: فواتير شراء + مدفوعات
    for (final Supplier s in suppliers) {
      double balance = 0;
      final List<PurchaseOrder> orders = purchaseOrders
          .where((PurchaseOrder o) => o.supplierId == s.id)
          .toList()
          .reversed
          .toList();

      for (final PurchaseOrder o in orders) {
        if (o.status == PurchaseOrderStatus.draft) continue;
        balance += o.total;
        list.add(
          LedgerEntry(
            id: 'LG-${number++}',
            partyId: s.id,
            date: o.date,
            type: LedgerType.purchase,
            description: 'أمر شراء ${o.id} — ${o.lines.length} صنف',
            amount: o.total,
            balanceAfter: balance,
          ),
        );

        if (o.status == PurchaseOrderStatus.completed) {
          final double paid = o.total * 0.6;
          balance -= paid;
          list.add(
            LedgerEntry(
              id: 'LG-${number++}',
              partyId: s.id,
              date: o.expectedDate,
              type: LedgerType.payment,
              description: 'دفعة تحت حساب أمر ${o.id}',
              amount: -paid,
              balanceAfter: balance,
            ),
          );
        }
      }
    }

    list.sort((LedgerEntry a, LedgerEntry b) => b.date.compareTo(a.date));
    return list;
  }

  static List<LedgerEntry> ledgerFor(String partyId) => ledgerEntries
      .where((LedgerEntry e) => e.partyId == partyId)
      .toList(growable: false);

  // ── نقاط الولاء ──────────────────────────────────────────────────────────
  static final List<LoyaltyEntry> loyaltyEntries = _buildLoyalty();

  static List<LoyaltyEntry> _buildLoyalty() {
    final List<LoyaltyEntry> list = <LoyaltyEntry>[];
    int number = 500;

    for (final Customer c in customers) {
      if (c.id == walkInCustomer.id || c.points == 0) continue;
      final List<SaleInvoice> invoices = invoicesForCustomer(c.id);

      for (int i = 0; i < invoices.length; i++) {
        final SaleInvoice inv = invoices[i];
        list.add(
          LoyaltyEntry(
            id: 'LP-${number++}',
            customerId: c.id,
            date: inv.date,
            type: LoyaltyType.earn,
            points: (inv.total / 10).round(),
            note: 'نقاط مكتسبة من فاتورة ${inv.id}',
          ),
        );

        if (i == 2) {
          list.add(
            LoyaltyEntry(
              id: 'LP-${number++}',
              customerId: c.id,
              date: inv.date.add(const Duration(days: 1)),
              type: LoyaltyType.redeem,
              points: -((c.points / 12).round()),
              note: 'استبدال نقاط بخصم على فاتورة',
            ),
          );
        }
      }
    }

    list.sort((LoyaltyEntry a, LoyaltyEntry b) => b.date.compareTo(a.date));
    return list;
  }

  static List<LoyaltyEntry> loyaltyFor(String customerId) => loyaltyEntries
      .where((LoyaltyEntry e) => e.customerId == customerId)
      .toList(growable: false);

  // ── سلسلة المبيعات اليومية (أساس الداشبورد) ──────────────────────────────
  /// سنة كاملة من البيانات اليومية — مشتقّة من أرقام ثابتة عشان تفضل متّسقة
  static final List<SalesPoint> _dailySeries = _buildSeries();

  static List<SalesPoint> _buildSeries() {
    final List<SalesPoint> list = <SalesPoint>[];

    for (int i = 364; i >= 0; i--) {
      final DateTime date = today.subtract(Duration(days: i));
      final int seed = _seedOf('d${date.year}${date.month}${date.day}');

      // الجمعة والسبت أعلى مبيعًا، مع نمو تدريجي على مدار السنة
      final bool weekend = date.weekday == DateTime.friday ||
          date.weekday == DateTime.saturday;
      final double base = 17500 + (seed % 9500) + (364 - i) * 24;
      final double sales = weekend ? base * 1.32 : base;

      final double marginRate = 0.22 + ((seed >> 3) % 9) / 100;
      final double cashRate = 0.40 + ((seed >> 5) % 11) / 100;
      final double cardRate = 0.25 + ((seed >> 7) % 8) / 100;
      final double walletRate = 0.08 + ((seed >> 9) % 6) / 100;

      final double cash = sales * cashRate;
      final double card = sales * cardRate;
      final double wallet = sales * walletRate;

      list.add(
        SalesPoint(
          date: date,
          sales: sales,
          profit: sales * marginRate,
          invoices: (sales / (150 + (seed % 70))).round(),
          cash: cash,
          card: card,
          wallet: wallet,
          credit: sales - cash - card - wallet,
        ),
      );
    }
    return list;
  }

  /// نافذة من السلسلة: [days] يوم، بإزاحة [offset] نافذة للخلف (للمقارنة).
  /// [branchId] بيقسّم الأرقام على حصة الفرع.
  static List<SalesPoint> seriesFor({
    required int days,
    String? branchId,
    int offset = 0,
  }) {
    final int end = _dailySeries.length - (offset * days);
    final int start = (end - days).clamp(0, _dailySeries.length);
    if (end <= 0) return const <SalesPoint>[];

    final List<SalesPoint> window =
        _dailySeries.sublist(start, end.clamp(0, _dailySeries.length));

    if (branchId == null) return window;

    final double share = branchById(branchId)?.share ?? 1;
    return <SalesPoint>[
      for (final SalesPoint p in window)
        SalesPoint(
          date: p.date,
          sales: p.sales * share,
          profit: p.profit * share,
          invoices: (p.invoices * share).round(),
          cash: p.cash * share,
          card: p.card * share,
          wallet: p.wallet * share,
          credit: p.credit * share,
        ),
    ];
  }

  /// أفضل المنتجات مبيعًا — أرقام ثابتة مشتقّة من الـid
  static List<ProductSalesStat> topProducts({int count = 5, int days = 30}) {
    final List<ProductSalesStat> stats = <ProductSalesStat>[
      for (final Product p in products)
        ProductSalesStat(
          product: p,
          units: ((_seedOf(p.id) % 340) + 20) * days ~/ 30,
          revenue: p.price * (((_seedOf(p.id) % 340) + 20) * days / 30),
        ),
    ];
    stats.sort(
      (ProductSalesStat a, ProductSalesStat b) =>
          b.revenue.compareTo(a.revenue),
    );
    return stats.take(count).toList(growable: false);
  }

  // ── المصروفات ────────────────────────────────────────────────────────────
  static const List<String> expenseCategories = <String>[
    'إيجار',
    'رواتب وأجور',
    'كهرباء ومياه',
    'صيانة',
    'نقل وشحن',
    'تسويق وإعلان',
    'مستلزمات تشغيل',
    'أخرى',
  ];

  static final List<Expense> expenses = <Expense>[
    _expense('EXP-241', 0, 'كهرباء ومياه', 'br-1', 4850.00,
        ExpenseStatus.pending, 'فاتورة الكهرباء عن شهر يوليو'),
    _expense('EXP-240', 1, 'نقل وشحن', 'br-2', 1240.50,
        ExpenseStatus.approved, 'شحن بضاعة من المخزن الرئيسي'),
    _expense('EXP-239', 2, 'صيانة', 'br-1', 2100.00, ExpenseStatus.approved,
        'صيانة تكييفات صالة العرض'),
    _expense('EXP-238', 3, 'تسويق وإعلان', 'br-1', 8500.00,
        ExpenseStatus.pending, 'حملة إعلانية على السوشيال ميديا'),
    _expense('EXP-237', 5, 'مستلزمات تشغيل', 'br-3', 960.75,
        ExpenseStatus.approved, 'أكياس وبكر فواتير'),
    _expense('EXP-236', 6, 'إيجار', 'br-2', 25000.00, ExpenseStatus.approved,
        'إيجار الفرع عن شهر أغسطس'),
    _expense('EXP-235', 8, 'رواتب وأجور', 'br-1', 68500.00,
        ExpenseStatus.approved, 'رواتب الفريق عن شهر يوليو'),
    _expense('EXP-234', 9, 'صيانة', 'br-3', 1750.00, ExpenseStatus.pending,
        'إصلاح ثلاجة العرض'),
    _expense('EXP-233', 11, 'كهرباء ومياه', 'br-2', 3920.00,
        ExpenseStatus.approved, 'فاتورة المياه والكهرباء'),
    _expense('EXP-232', 13, 'نقل وشحن', 'br-1', 2380.25,
        ExpenseStatus.approved, 'مصاريف توصيل طلبات العملاء'),
    _expense('EXP-231', 15, 'مستلزمات تشغيل', 'br-1', 1420.00,
        ExpenseStatus.approved, 'أدوات نظافة ومستلزمات'),
    _expense('EXP-230', 18, 'إيجار', 'br-3', 18000.00, ExpenseStatus.approved,
        'إيجار فرع الإسكندرية'),
    _expense('EXP-229', 21, 'تسويق وإعلان', 'br-2', 5600.00,
        ExpenseStatus.approved, 'بانرات ولافتات دعائية'),
    _expense('EXP-228', 24, 'أخرى', 'br-1', 3150.00, ExpenseStatus.pending,
        'مصروفات نثرية متنوعة'),
  ];

  static Expense _expense(
    String id,
    int daysAgo,
    String category,
    String branchId,
    double amount,
    ExpenseStatus status,
    String note,
  ) =>
      Expense(
        id: id,
        date: today.subtract(Duration(days: daysAgo)),
        category: category,
        branchId: branchId,
        amount: amount,
        status: status,
        note: note,
        createdBy: currentUser.name,
      );

  /// مصروفات آخر 30 يوم
  static double get monthExpenses {
    final DateTime from = today.subtract(const Duration(days: 30));
    return expenses
        .where((Expense e) => e.date.isAfter(from))
        .fold<double>(0, (double s, Expense e) => s + e.amount);
  }

  /// صافي النقدية = كاش المبيعات خلال 30 يوم − المصروفات المعتمدة
  static double get netCash {
    final double cashSales = seriesFor(days: 30)
        .fold<double>(0, (double s, SalesPoint p) => s + p.cash);
    final double approved = expenses
        .where((Expense e) => e.status == ExpenseStatus.approved)
        .fold<double>(0, (double s, Expense e) => s + e.amount);
    return cashSales - approved;
  }

  // ── الأجهزة المتصلة ──────────────────────────────────────────────────────
  static const List<ConnectedDevice> devices = <ConnectedDevice>[
    ConnectedDevice(
      type: DeviceType.printer,
      model: 'Epson TM-T20III',
      port: 'USB001',
      isConnected: true,
    ),
    ConnectedDevice(
      type: DeviceType.cashDrawer,
      model: 'Posiflex CR-4000',
      port: 'RJ11 — عبر الطابعة',
      isConnected: true,
    ),
    ConnectedDevice(
      type: DeviceType.scanner,
      model: 'Honeywell Voyager 1200g',
      port: 'USB002',
      isConnected: true,
    ),
    ConnectedDevice(
      type: DeviceType.scale,
      model: 'Bizerba SC II',
      port: 'COM3',
      isConnected: false,
    ),
  ];

  // ── الوردية الحالية ──────────────────────────────────────────────────────
  static ShiftSummary get currentShift => ShiftSummary(
        id: 'SH-1042',
        employeeId: 'e-2',
        branchId: 'br-1',
        startedAt: DateTime(2026, 8, 13, 9, 12),
        openingBalance: 2000,
        cashSales: 14620.75,
        cardSales: 7480.50,
        walletSales: 2279.25,
        cashIn: 1500,
        cashOut: 860.50,
        invoicesCount: 63,
      );

  // ── العروض والخصومات ─────────────────────────────────────────────────────
  static final List<Promotion> promotions = <Promotion>[
    Promotion(
      id: 'PR-01',
      name: 'خصم الصيف على المشروبات',
      type: PromotionType.percentage,
      value: '15%',
      scope: 'كل أصناف فئة المشروبات',
      startDate: today.subtract(const Duration(days: 12)),
      endDate: today.add(const Duration(days: 18)),
      usageCount: 342,
    ),
    Promotion(
      id: 'PR-02',
      name: 'اشترِ 2 واحصل على 1 مجانًا',
      type: PromotionType.buyXGetY,
      value: '2+1',
      scope: 'شيبسي وسناكس مختارة',
      startDate: today.subtract(const Duration(days: 5)),
      endDate: today.add(const Duration(days: 25)),
      usageCount: 186,
    ),
    Promotion(
      id: 'PR-03',
      name: 'خصم الجملة على الأرز والزيت',
      type: PromotionType.quantityDiscount,
      value: 'خصم 12% من 10 وحدات',
      scope: 'بقالة — كميات كبيرة',
      startDate: today.subtract(const Duration(days: 40)),
      endDate: today.add(const Duration(days: 50)),
      usageCount: 94,
    ),
    Promotion(
      id: 'PR-04',
      name: 'عرض العودة للمدارس',
      type: PromotionType.percentage,
      value: '20%',
      scope: 'ملابس ومستلزمات',
      startDate: today.add(const Duration(days: 6)),
      endDate: today.add(const Duration(days: 36)),
      usageCount: 0,
    ),
    Promotion(
      id: 'PR-05',
      name: 'خصم العملاء الذهبيين',
      type: PromotionType.percentage,
      value: '10%',
      scope: 'كل المنتجات — للعملاء الذهبيين فقط',
      startDate: today.subtract(const Duration(days: 90)),
      endDate: today.add(const Duration(days: 120)),
      usageCount: 512,
    ),
    Promotion(
      id: 'PR-06',
      name: 'عرض رمضان على الألبان',
      type: PromotionType.buyXGetY,
      value: '3+1',
      scope: 'ألبان وأجبان',
      startDate: today.subtract(const Duration(days: 120)),
      endDate: today.subtract(const Duration(days: 60)),
      usageCount: 738,
    ),
    Promotion(
      id: 'PR-07',
      name: 'خصم الشحن على الإلكترونيات',
      type: PromotionType.quantityDiscount,
      value: 'خصم 200 ج.م من 3 قطع',
      scope: 'إلكترونيات',
      startDate: today.subtract(const Duration(days: 30)),
      endDate: today.subtract(const Duration(days: 2)),
      usageCount: 41,
    ),
    Promotion(
      id: 'PR-08',
      name: 'عرض نهاية الأسبوع',
      type: PromotionType.percentage,
      value: '8%',
      scope: 'كل الفروع — الجمعة والسبت',
      startDate: today.add(const Duration(days: 2)),
      endDate: today.add(const Duration(days: 60)),
      usageCount: 0,
    ),
    Promotion(
      id: 'PR-09',
      name: 'خصم العناية الشخصية',
      type: PromotionType.quantityDiscount,
      value: 'خصم 18% من 5 وحدات',
      scope: 'عناية شخصية',
      startDate: today.subtract(const Duration(days: 8)),
      endDate: today.add(const Duration(days: 12)),
      usageCount: 127,
    ),
  ];

  // ── برنامج الولاء ────────────────────────────────────────────────────────
  /// عدد النقاط المكتسبة عن كل جنيه
  static const double pointsPerEgp = 0.1;

  /// قيمة النقطة الواحدة بالجنيه عند الاستبدال
  static const double pointValue = 0.1;

  static const List<LoyaltyTierInfo> loyaltyTiers = <LoyaltyTierInfo>[
    LoyaltyTierInfo(
      name: 'فضي',
      minPoints: 500,
      icon: Icons.workspace_premium_outlined,
      gradient: <Color>[Color(0xFF94A3B8), Color(0xFF64748B)],
      benefits: <String>[
        'خصم 3% على كل المشتريات',
        'نقطة لكل جنيه بدون حد أدنى',
        'إشعارات العروض قبل الجميع',
        'صلاحية النقاط 12 شهرًا',
      ],
    ),
    LoyaltyTierInfo(
      name: 'ذهبي',
      minPoints: 2500,
      icon: Icons.military_tech_outlined,
      gradient: <Color>[Color(0xFFF59E0B), Color(0xFFB45309)],
      benefits: <String>[
        'خصم 7% على كل المشتريات',
        'نقاط مضاعفة ×1.5',
        'شحن مجاني للطلبات',
        'أولوية في خدمة العملاء',
        'صلاحية النقاط 18 شهرًا',
      ],
    ),
    LoyaltyTierInfo(
      name: 'بلاتيني',
      minPoints: 6000,
      icon: Icons.diamond_outlined,
      gradient: <Color>[Color(0xFF6366F1), Color(0xFF4C1D95)],
      benefits: <String>[
        'خصم 12% على كل المشتريات',
        'نقاط مضاعفة ×2',
        'هدية عيد ميلاد سنوية',
        'مدير حساب مخصص',
        'حد ائتماني أعلى',
        'صلاحية النقاط دائمة',
      ],
    ),
  ];

  /// العملاء مرتبين حسب النقاط تنازليًا
  static List<Customer> get topCustomersByPoints {
    final List<Customer> list = customers
        .where((Customer c) => c.id != walkInCustomer.id && c.points > 0)
        .toList();
    list.sort((Customer a, Customer b) => b.points.compareTo(a.points));
    return list;
  }

  static LoyaltyTierInfo? tierForPoints(int points) {
    LoyaltyTierInfo? match;
    for (final LoyaltyTierInfo t in loyaltyTiers) {
      if (points >= t.minPoints) match = t;
    }
    return match;
  }

  // ── أسباب الإرجاع وطرق الاسترداد ─────────────────────────────────────────
  static const List<String> returnReasons = <String>[
    'منتج تالف أو معيب',
    'صنف مختلف عن المطلوب',
    'العميل غيّر رأيه',
    'خطأ في إدخال الفاتورة',
    'انتهاء الصلاحية',
    'سبب آخر',
  ];

  static const List<String> refundMethods = <String>[
    'استرداد نقدي',
    'إرجاع على البطاقة',
    'رصيد للعميل',
    'استبدال بصنف آخر',
  ];

  // ── منتجات كل مورد ───────────────────────────────────────────────────────
  static const Map<String, List<String>> _supplierCategories =
      <String, List<String>>{
    's-1': <String>['cat-grocery', 'cat-dairy'],
    's-2': <String>['cat-drinks', 'cat-snacks'],
    's-3': <String>['cat-pharmacy', 'cat-care'],
    's-4': <String>['cat-clothes'],
    's-5': <String>['cat-electronics'],
  };

  static List<Product> productsBySupplier(String supplierId) {
    final List<String> cats = _supplierCategories[supplierId] ?? <String>[];
    return products
        .where((Product p) => cats.contains(p.categoryId))
        .toList(growable: false);
  }

  static Supplier? supplierById(String id) {
    for (final Supplier s in suppliers) {
      if (s.id == id) return s;
    }
    return null;
  }

  static Customer? customerById(String id) {
    for (final Customer c in customers) {
      if (c.id == id) return c;
    }
    return null;
  }

  static Employee? employeeById(String id) {
    for (final Employee e in employees) {
      if (e.id == id) return e;
    }
    return null;
  }

  static Role? roleById(String id) {
    for (final Role r in roles) {
      if (r.id == id) return r;
    }
    return null;
  }

  /// الحد الائتماني لكل عميل (مشتق من حجم تعاملاته)
  static double creditLimitFor(Customer c) {
    if (c.totalPurchases >= 300000) return 50000;
    if (c.totalPurchases >= 100000) return 25000;
    if (c.totalPurchases >= 30000) return 10000;
    return 5000;
  }

  // ── تواريخ الصلاحية ──────────────────────────────────────────────────────
  /// المنتجات اللي ليها صلاحية بس — الباقي (ملابس/إلكترونيات) مالهوش
  static final Map<String, DateTime> expiryDates = <String, DateTime>{
    'p-3003': DateTime(2026, 8, 15),
    'p-3001': DateTime(2026, 8, 20),
    'p-2003': DateTime(2026, 8, 25),
    'p-4003': DateTime(2026, 8, 30),
    'p-3002': DateTime(2026, 9, 2),
    'p-5002': DateTime(2026, 9, 8),
    'p-3004': DateTime(2026, 10, 14),
    'p-2002': DateTime(2026, 12, 1),
    'p-1005': DateTime(2027, 1, 10),
    'p-5001': DateTime(2027, 4, 1),
    'p-6002': DateTime(2027, 6, 1),
    'p-1002': DateTime(2027, 3, 22),
  };

  // ── أرصدة المخزون لكل فرع ────────────────────────────────────────────────
  /// توزيع تقريبي للمخزون على الفروع: 50% / 30% / 20%
  static const List<double> _branchShare = <double>[0.5, 0.3, 0.2];

  static final List<StockRecord> stockRecords = <StockRecord>[
    for (final Product p in products)
      for (int i = 0; i < branches.length; i++) _stockRecordFor(p, i),
  ];

  static StockRecord _stockRecordFor(Product product, int branchIndex) {
    final int seed = _seedOf(product.id) + branchIndex * 17;
    final int onHand = (product.stock * _branchShare[branchIndex]).round();
    final int reserved =
        onHand == 0 ? 0 : (onHand * ((seed % 9) + 2) / 100).round();

    return StockRecord(
      productId: product.id,
      branchId: branches[branchIndex].id,
      onHand: onHand,
      reserved: reserved,
      lastMovement: today.subtract(
        Duration(days: seed % 14, hours: seed % 11),
      ),
    );
  }

  /// رقم ثابت مشتق من الـid — عشان البيانات ماتتغيرش كل تشغيل
  static int _seedOf(String id) {
    int hash = 7;
    for (final int code in id.codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }
    return hash;
  }

  // ── Helpers ──────────────────────────────────────────────────────────────
  static ProductCategory? categoryById(String id) {
    for (final ProductCategory c in categories) {
      if (c.id == id) return c;
    }
    return null;
  }

  static Branch? branchById(String id) {
    for (final Branch b in branches) {
      if (b.id == id) return b;
    }
    return null;
  }

  static List<Product> productsByCategory(String? categoryId) {
    if (categoryId == null) return products;
    return products
        .where((Product p) => p.categoryId == categoryId)
        .toList(growable: false);
  }

  static List<Product> searchProducts(String query, {String? categoryId}) {
    final List<Product> scoped = productsByCategory(categoryId);
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return scoped;
    return scoped
        .where((Product p) =>
            p.name.toLowerCase().contains(q) ||
            p.sku.toLowerCase().contains(q) ||
            p.barcode.contains(q))
        .toList(growable: false);
  }

  static Product? productById(String id) {
    for (final Product p in products) {
      if (p.id == id) return p;
    }
    return null;
  }

  static List<Product> get lowStockProducts =>
      products.where((Product p) => p.isLowStock).toList(growable: false);

  static List<Product> get outOfStockProducts =>
      products.where((Product p) => p.isOutOfStock).toList(growable: false);

  static List<Product> get inactiveProducts =>
      products.where((Product p) => !p.isActive).toList(growable: false);

  static List<Product> get nearExpiryProducts =>
      products.where((Product p) => p.isNearExpiry).toList(growable: false);

  /// إجمالي قيمة المخزون بسعر التكلفة
  static double get inventoryValue => products.fold<double>(
        0,
        (double sum, Product p) => sum + (p.cost * p.stock),
      );

  /// رصيد منتج معيّن في فرع معيّن (0 لو مفيش سجل)
  static StockRecord? stockRecordFor(String productId, String branchId) {
    for (final StockRecord r in stockRecords) {
      if (r.productId == productId && r.branchId == branchId) return r;
    }
    return null;
  }

  static int availableAt(String productId, String branchId) =>
      stockRecordFor(productId, branchId)?.available ?? 0;

  static int onHandAt(String productId, String branchId) =>
      stockRecordFor(productId, branchId)?.onHand ?? 0;

  static List<StockRecord> stockByBranch(String? branchId) {
    if (branchId == null) return stockRecords;
    return stockRecords
        .where((StockRecord r) => r.branchId == branchId)
        .toList(growable: false);
  }

  /// نسبة الضريبة المطبّقة على الفواتير
  static const double taxRate = 0.14;
}
