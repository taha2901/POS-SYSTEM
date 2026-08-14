import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/employees_sort_column.dart';

/// حالة شاشة الموظفين: البحث، الدور، الفرع، والفرز.
class EmployeesListController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  String _query = '';
  String? _branchId;
  String? _roleId;
  int _sortIndex = 0;
  bool _sortAscending = true;

  List<Employee>? _cachedRows;

  String? get branchId => _branchId;
  String? get roleId => _roleId;
  int get sortIndex => _sortIndex;
  bool get sortAscending => _sortAscending;

  List<Employee> get rows => _cachedRows ??= _computeRows();

  int get visibleCount => rows.length;

  double get visibleTodaySales =>
      rows.fold<double>(0, (double s, Employee e) => s + e.todaySales);

  // ── إحصائيات ─────────────────────────────────────────────────────────────
  int get activeCount =>
      MockData.employees.where((Employee e) => e.isActive).length;

  double get todaySales => MockData.employees
      .fold<double>(0, (double s, Employee e) => s + e.todaySales);

  double get totalSalaries => MockData.employees
      .fold<double>(0, (double s, Employee e) => s + e.salary);

  // ── الفلترة والفرز ───────────────────────────────────────────────────────
  List<Employee> _computeRows() {
    final String q = _query.trim().toLowerCase();

    final List<Employee> list = MockData.employees.where((Employee e) {
      if (_branchId != null && e.branchId != _branchId) return false;
      if (_roleId != null && e.roleId != _roleId) return false;
      if (q.isEmpty) return true;
      return e.name.toLowerCase().contains(q) ||
          e.role.toLowerCase().contains(q) ||
          e.phone.contains(q);
    }).toList();

    final EmployeesSortColumn column = EmployeesSortColumn.values[_sortIndex];
    list.sort((Employee a, Employee b) {
      final int result = switch (column) {
        EmployeesSortColumn.name => a.name.compareTo(b.name),
        EmployeesSortColumn.role => a.role.compareTo(b.role),
        EmployeesSortColumn.branch => a.branchName.compareTo(b.branchName),
        EmployeesSortColumn.status =>
          (a.isActive ? 0 : 1).compareTo(b.isActive ? 0 : 1),
        EmployeesSortColumn.lastLogin => a.lastLogin.compareTo(b.lastLogin),
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

  void setRole(String? id) {
    _roleId = id;
    _refresh();
  }

  void setBranch(String? id) {
    _branchId = id;
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
