import 'package:flutter/foundation.dart';

import '../../../mock_data/mock_data.dart';
import '../models/stock_sort_column.dart';

/// حالة شاشة المخزون: الفرع المختار وفرز الجدول.
class InventoryController extends ChangeNotifier {
  String? _branchId;
  int _sortIndex = 2;
  bool _sortAscending = true;

  /// نتيجة الفلترة والفرز — بتتحسب مرة واحدة لحد ما حاجة تتغيّر.
  List<StockRecord>? _cachedRows;

  String? get branchId => _branchId;
  int get sortIndex => _sortIndex;
  bool get sortAscending => _sortAscending;

  List<StockRecord> get rows => _cachedRows ??= _computeRows();

  int get visibleCount => rows.length;

  double get visibleValue =>
      rows.fold<double>(0, (double s, StockRecord r) => s + r.value);

  List<StockRecord> _computeRows() {
    final List<StockRecord> list = MockData.stockByBranch(_branchId).toList();
    final StockSortColumn column = StockSortColumn.values[_sortIndex];

    list.sort((StockRecord a, StockRecord b) {
      final int result = switch (column) {
        StockSortColumn.product => a.product.name.compareTo(b.product.name),
        StockSortColumn.branch => a.branch.name.compareTo(b.branch.name),
        StockSortColumn.onHand => a.onHand.compareTo(b.onHand),
        StockSortColumn.reserved => a.reserved.compareTo(b.reserved),
        StockSortColumn.available => a.available.compareTo(b.available),
        StockSortColumn.lastMovement =>
          a.lastMovement.compareTo(b.lastMovement),
      };
      return _sortAscending ? result : -result;
    });

    return list;
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
}
