import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/supplier_filter.dart';
import '../models/suppliers_sort_column.dart';

/// حالة شاشة الموردين: البحث، الفلتر، والفرز.
class SuppliersListController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  String _query = '';
  SupplierFilter _filter = SupplierFilter.all;
  int _sortIndex = 0;
  bool _sortAscending = true;

  List<Supplier>? _cachedRows;

  SupplierFilter get filter => _filter;
  int get sortIndex => _sortIndex;
  bool get sortAscending => _sortAscending;

  List<Supplier> get rows => _cachedRows ??= _computeRows();

  int get visibleCount => rows.length;

  double get visibleDue =>
      rows.fold<double>(0, (double s, Supplier x) => s + x.balanceDue);

  // ── إحصائيات ─────────────────────────────────────────────────────────────
  double get totalDue => MockData.suppliers
      .fold<double>(0, (double s, Supplier x) => s + x.balanceDue);

  int get activeCount =>
      MockData.suppliers.where((Supplier s) => s.isActive).length;

  double get totalPurchases => MockData.suppliers
      .fold<double>(0, (double s, Supplier x) => s + x.totalPurchases);

  // ── الفلترة والفرز ───────────────────────────────────────────────────────
  List<Supplier> _computeRows() {
    final String q = _query.trim().toLowerCase();

    final List<Supplier> list = MockData.suppliers.where((Supplier s) {
      final bool matchesFilter = switch (_filter) {
        SupplierFilter.all => true,
        SupplierFilter.active => s.isActive,
        SupplierFilter.inactive => !s.isActive,
        SupplierFilter.due => s.balanceDue > 0,
      };
      if (!matchesFilter) return false;
      if (q.isEmpty) return true;
      return s.name.toLowerCase().contains(q) ||
          s.contactPerson.toLowerCase().contains(q) ||
          s.phone.contains(q);
    }).toList();

    final SuppliersSortColumn column = SuppliersSortColumn.values[_sortIndex];
    list.sort((Supplier a, Supplier b) {
      final int result = switch (column) {
        SuppliersSortColumn.name => a.name.compareTo(b.name),
        SuppliersSortColumn.contact =>
          a.contactPerson.compareTo(b.contactPerson),
        SuppliersSortColumn.phone => a.phone.compareTo(b.phone),
        SuppliersSortColumn.balance => a.balanceDue.compareTo(b.balanceDue),
        SuppliersSortColumn.orders => a.ordersCount.compareTo(b.ordersCount),
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

  void setFilter(SupplierFilter filter) {
    _filter = filter;
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
