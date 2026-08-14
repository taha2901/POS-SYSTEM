import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/purchase_orders_sort_column.dart';

/// حالة شاشة أوامر الشراء: البحث، المورد، الحالة، والفرز.
class PurchaseOrdersController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  String _query = '';
  String? _supplierId;
  PurchaseOrderStatus? _status;
  int _sortIndex = 2;
  bool _sortAscending = false;

  /// نتيجة الفلترة والفرز — بتتحسب مرة واحدة لحد ما حاجة تتغيّر.
  List<PurchaseOrder>? _cachedRows;

  String? get supplierId => _supplierId;
  PurchaseOrderStatus? get status => _status;
  int get sortIndex => _sortIndex;
  bool get sortAscending => _sortAscending;

  List<PurchaseOrder> get rows => _cachedRows ??= _computeRows();

  int get visibleCount => rows.length;

  double get visibleValue =>
      rows.fold<double>(0, (double s, PurchaseOrder o) => s + o.total);

  // ── إحصائيات أعلى الشاشة ─────────────────────────────────────────────────
  int countByStatus(PurchaseOrderStatus status) => MockData.purchaseOrders
      .where((PurchaseOrder o) => o.status == status)
      .length;

  int get awaitingCount =>
      countByStatus(PurchaseOrderStatus.confirmed) +
      countByStatus(PurchaseOrderStatus.partiallyReceived);

  double get pendingValue => MockData.purchaseOrders
      .where((PurchaseOrder o) => o.isReceivable)
      .fold<double>(0, (double s, PurchaseOrder o) => s + o.total);

  // ── الفلترة والفرز ───────────────────────────────────────────────────────
  List<PurchaseOrder> _computeRows() {
    final String q = _query.trim().toLowerCase();

    final List<PurchaseOrder> list =
        MockData.purchaseOrders.where((PurchaseOrder o) {
      if (_supplierId != null && o.supplierId != _supplierId) return false;
      if (_status != null && o.status != _status) return false;
      if (q.isEmpty) return true;
      return o.id.toLowerCase().contains(q) ||
          o.supplier.name.toLowerCase().contains(q);
    }).toList();

    final PurchaseOrdersSortColumn column =
        PurchaseOrdersSortColumn.values[_sortIndex];

    list.sort((PurchaseOrder a, PurchaseOrder b) {
      final int result = switch (column) {
        PurchaseOrdersSortColumn.id => a.id.compareTo(b.id),
        PurchaseOrdersSortColumn.supplier =>
          a.supplier.name.compareTo(b.supplier.name),
        PurchaseOrdersSortColumn.date => a.date.compareTo(b.date),
        PurchaseOrdersSortColumn.status =>
          a.status.index.compareTo(b.status.index),
        PurchaseOrdersSortColumn.total => a.total.compareTo(b.total),
      };
      return _sortAscending ? result : -result;
    });

    return list;
  }

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void setQuery(String value) {
    _query = value;
    _refresh();
  }

  void setSupplier(String? id) {
    _supplierId = id;
    _refresh();
  }

  void setStatus(PurchaseOrderStatus? status) {
    _status = status;
    _refresh();
  }

  void sortBy(int columnIndex, bool ascending) {
    _sortIndex = columnIndex;
    _sortAscending = ascending;
    _refresh();
  }

  void _refresh() {
    _cachedRows = null;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
