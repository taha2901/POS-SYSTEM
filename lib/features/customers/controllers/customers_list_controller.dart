import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/customers_sort_column.dart';

/// حالة شاشة العملاء: البحث، المجموعة، فلتر المدينين، والفرز.
class CustomersListController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  String _query = '';
  CustomerTier? _tier;
  bool _onlyDebtors = false;
  int _sortIndex = 0;
  bool _sortAscending = true;

  List<Customer>? _cachedRows;

  CustomerTier? get tier => _tier;
  bool get onlyDebtors => _onlyDebtors;
  int get sortIndex => _sortIndex;
  bool get sortAscending => _sortAscending;

  /// كل العملاء ما عدا "عميل نقدي" (مش عميل حقيقي)
  List<Customer> get allCustomers => MockData.customers
      .where((Customer c) => c.id != MockData.walkInCustomer.id)
      .toList(growable: false);

  List<Customer> get rows => _cachedRows ??= _computeRows();

  int get visibleCount => rows.length;

  double get visibleBalance =>
      rows.fold<double>(0, (double s, Customer c) => s + c.balance);

  // ── إحصائيات ─────────────────────────────────────────────────────────────
  double get totalDebt => allCustomers
      .where((Customer c) => c.balance < 0)
      .fold<double>(0, (double s, Customer c) => s + c.balance.abs());

  double get totalPurchases => allCustomers
      .fold<double>(0, (double s, Customer c) => s + c.totalPurchases);

  int tierCount(CustomerTier tier) =>
      allCustomers.where((Customer c) => c.tier == tier).length;

  // ── الفلترة والفرز ───────────────────────────────────────────────────────
  List<Customer> _computeRows() {
    final String q = _query.trim().toLowerCase();

    final List<Customer> list = allCustomers.where((Customer c) {
      if (_tier != null && c.tier != _tier) return false;
      if (_onlyDebtors && c.balance >= 0) return false;
      if (q.isEmpty) return true;
      return c.name.toLowerCase().contains(q) ||
          c.phone.contains(q) ||
          c.email.toLowerCase().contains(q);
    }).toList();

    final CustomersSortColumn column = CustomersSortColumn.values[_sortIndex];
    list.sort((Customer a, Customer b) {
      final int result = switch (column) {
        CustomersSortColumn.name => a.name.compareTo(b.name),
        CustomersSortColumn.phone => a.phone.compareTo(b.phone),
        CustomersSortColumn.tier => a.tier.index.compareTo(b.tier.index),
        CustomersSortColumn.balance => a.balance.compareTo(b.balance),
        CustomersSortColumn.lastVisit => a.lastVisit.compareTo(b.lastVisit),
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

  void setTier(CustomerTier? tier) {
    _tier = tier;
    _refresh();
  }

  void toggleOnlyDebtors() {
    _onlyDebtors = !_onlyDebtors;
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
