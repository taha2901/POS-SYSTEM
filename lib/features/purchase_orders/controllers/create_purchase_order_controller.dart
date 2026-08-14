import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../../mock_data/mock_data.dart';
import '../models/draft_order_line.dart';

/// حالة أمر الشراء الجديد: المورد، فرع الاستلام، والأصناف المضافة.
class CreatePurchaseOrderController extends ChangeNotifier {
  String _supplierId = MockData.suppliers.first.id;
  String _branchId = MockData.branches.first.id;
  final List<DraftOrderLine> _lines = <DraftOrderLine>[];

  /// الكمية المبدئية لأي صنف بيتضاف
  static const int _defaultQuantity = 10;

  String get supplierId => _supplierId;
  String get branchId => _branchId;

  UnmodifiableListView<DraftOrderLine> get lines =>
      UnmodifiableListView<DraftOrderLine>(_lines);

  Supplier get supplier => MockData.supplierById(_supplierId)!;

  bool get hasLines => _lines.isNotEmpty;

  // ── الإجماليات ───────────────────────────────────────────────────────────
  double get subtotal =>
      _lines.fold<double>(0, (double s, DraftOrderLine l) => s + l.total);

  double get tax => subtotal * MockData.taxRate;

  double get total => subtotal + tax;

  int get totalUnits =>
      _lines.fold<int>(0, (int s, DraftOrderLine l) => s + l.quantity);

  /// المنتجات المضافة بالفعل — عشان ما تتكررش في نافذة الاختيار.
  Set<String> get pickedProductIds =>
      _lines.map((DraftOrderLine l) => l.product.id).toSet();

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void setSupplier(String id) {
    _supplierId = id;
    notifyListeners();
  }

  void setBranch(String id) {
    _branchId = id;
    notifyListeners();
  }

  void addProduct(Product product) {
    _lines.add(
      DraftOrderLine(
        product: product,
        quantity: _defaultQuantity,
        unitCost: product.cost,
      ),
    );
    notifyListeners();
  }

  /// يضيف كل منتجات المورد المختار دفعة واحدة.
  void addSupplierCatalog() {
    final Set<String> existing = pickedProductIds;
    final List<Product> catalog = MockData.productsBySupplier(_supplierId)
        .where((Product p) => !existing.contains(p.id))
        .toList();

    if (catalog.isEmpty) return;

    for (final Product p in catalog) {
      _lines.add(
        DraftOrderLine(
          product: p,
          quantity: _defaultQuantity,
          unitCost: p.cost,
        ),
      );
    }
    notifyListeners();
  }

  void removeLineAt(int index) {
    _lines.removeAt(index);
    notifyListeners();
  }

  void setQuantity(DraftOrderLine line, int quantity) {
    line.quantity = quantity;
    notifyListeners();
  }

  void setUnitCost(DraftOrderLine line, double cost) {
    line.unitCost = cost;
    notifyListeners();
  }
}
