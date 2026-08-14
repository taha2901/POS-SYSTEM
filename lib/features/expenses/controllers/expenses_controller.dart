import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/expenses_sort_column.dart';

/// حالة شاشة المصروفات: القائمة المضافة والفلاتر والفرز.
class ExpensesController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  /// المصروفات المضافة في الجلسة الحالية — بتتحط فوق بيانات الـMock.
  final List<Expense> _extra = <Expense>[];

  String _query = '';
  String? _category;
  String? _branchId;
  ExpenseStatus? _status;
  int _sortIndex = 0;
  bool _sortAscending = false;

  String? get category => _category;
  String? get branchId => _branchId;
  ExpenseStatus? get status => _status;
  int get sortIndex => _sortIndex;
  bool get sortAscending => _sortAscending;

  List<Expense> get all => <Expense>[..._extra, ...MockData.expenses];

  List<Expense> get rows {
    final String q = _query.trim().toLowerCase();

    final List<Expense> list = all.where((Expense e) {
      if (_category != null && e.category != _category) return false;
      if (_branchId != null && e.branchId != _branchId) return false;
      if (_status != null && e.status != _status) return false;
      if (q.isEmpty) return true;
      return e.id.toLowerCase().contains(q) ||
          e.note.toLowerCase().contains(q) ||
          e.category.contains(q);
    }).toList();

    final ExpensesSortColumn column = ExpensesSortColumn.values[_sortIndex];
    list.sort((Expense a, Expense b) {
      final int result = switch (column) {
        ExpensesSortColumn.date => a.date.compareTo(b.date),
        ExpensesSortColumn.category => a.category.compareTo(b.category),
        ExpensesSortColumn.branch =>
          (a.branch?.name ?? '').compareTo(b.branch?.name ?? ''),
        ExpensesSortColumn.amount => a.amount.compareTo(b.amount),
        ExpensesSortColumn.status => a.status.index.compareTo(b.status.index),
      };
      return _sortAscending ? result : -result;
    });

    return list;
  }

  int get visibleCount => rows.length;

  double get visibleTotal =>
      rows.fold<double>(0, (double s, Expense e) => s + e.amount);

  double get pendingTotal => all
      .where((Expense e) => e.status == ExpenseStatus.pending)
      .fold<double>(0, (double s, Expense e) => s + e.amount);

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setCategory(String? category) {
    _category = category;
    notifyListeners();
  }

  void setBranch(String? id) {
    _branchId = id;
    notifyListeners();
  }

  void setStatus(ExpenseStatus? status) {
    _status = status;
    notifyListeners();
  }

  void sortBy(int columnIndex, bool ascending) {
    _sortIndex = columnIndex;
    _sortAscending = ascending;
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _extra.insert(0, expense);
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
