import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/product_form_tab.dart';
import '../models/product_variant.dart';

/// حالة نموذج المنتج كامل: كل الحقول + التبويب المفتوح.
class ProductFormController extends ChangeNotifier {
  ProductFormController({required TickerProvider vsync}) {
    tabController = TabController(
      length: ProductFormTab.values.length,
      vsync: vsync,
    )..addListener(() {
        if (tabController.indexIsChanging) notifyListeners();
      });
  }

  /// الوحدات المتاحة في تبويب المخزون
  static const List<String> units = <String>[
    'قطعة',
    'كيس',
    'علبة',
    'كرتونة',
    'زجاجة',
    'كيلو',
    'شريط',
  ];

  late final TabController tabController;

  // ── بيانات أساسية ────────────────────────────────────────────────────────
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String _categoryId = MockData.categories.first.id;

  // ── التسعير ──────────────────────────────────────────────────────────────
  final TextEditingController costController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // ── المتغيرات ────────────────────────────────────────────────────────────
  final List<ProductVariant> _variants = <ProductVariant>[ProductVariant()];

  // ── المخزون ──────────────────────────────────────────────────────────────
  final TextEditingController reorderController =
      TextEditingController(text: '10');
  final TextEditingController openingStockController =
      TextEditingController(text: '0');
  String _unit = 'قطعة';

  // ── الباركود ─────────────────────────────────────────────────────────────
  String _barcode = '6221030000017';

  String get categoryId => _categoryId;
  String get unit => _unit;
  String get barcode => _barcode;
  List<ProductVariant> get variants => List<ProductVariant>.unmodifiable(
        _variants,
      );

  int get currentTabIndex => tabController.index;

  // ── حسابات التسعير ───────────────────────────────────────────────────────
  double get cost => double.tryParse(costController.text.trim()) ?? 0;
  double get price => double.tryParse(priceController.text.trim()) ?? 0;
  double get profit => price - cost;
  double get margin => price <= 0 ? 0 : (profit / price) * 100;
  bool get hasPricing => cost > 0 && price > 0;
  bool get isLoss => hasPricing && profit < 0;

  // ── حالة الحفظ ───────────────────────────────────────────────────────────
  String get productName => nameController.text.trim();
  bool get hasName => productName.isNotEmpty;

  /// نص التنبيه في تبويب المخزون
  String get reorderPoint =>
      reorderController.text.trim().isEmpty ? '0' : reorderController.text.trim();

  // ── إجراءات ──────────────────────────────────────────────────────────────
  /// أي تغيير في حقل نصي بيعيد بناء الأجزاء اللي بتعتمد عليه.
  void fieldChanged([String? _]) => notifyListeners();

  void setCategory(String id) {
    _categoryId = id;
    notifyListeners();
  }

  void setUnit(String unit) {
    _unit = unit;
    notifyListeners();
  }

  void addVariant() {
    _variants.add(ProductVariant());
    notifyListeners();
  }

  void removeVariantAt(int index) {
    _variants.removeAt(index);
    notifyListeners();
  }

  void generateBarcode() {
    // رقم ثابت مشتق من الوقت — كافي كـPlaceholder
    final int suffix =
        DateTime.now().millisecondsSinceEpoch.remainder(10000000);
    _barcode = '622103${suffix.toString().padLeft(7, '0')}';
    notifyListeners();
  }

  void goToTab(ProductFormTab tab) => tabController.animateTo(tab.index);

  @override
  void dispose() {
    tabController.dispose();
    nameController.dispose();
    brandController.dispose();
    descriptionController.dispose();
    costController.dispose();
    priceController.dispose();
    reorderController.dispose();
    openingStockController.dispose();
    super.dispose();
  }
}
