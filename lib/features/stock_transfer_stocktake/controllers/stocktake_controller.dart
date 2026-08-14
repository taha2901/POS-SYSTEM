import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/stocktake_line.dart';

/// حالة شاشة الجرد: الفرع، البحث، والكميات الفعلية المُدخلة.
class StocktakeController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  String _branchId = MockData.branches.first.id;
  String _query = '';
  late List<StocktakeLine> _lines = _buildLines();

  String get branchId => _branchId;
  String get query => _query;
  List<StocktakeLine> get lines => _lines;

  Branch get branch => MockData.branchById(_branchId)!;

  List<StocktakeLine> _buildLines() {
    return <StocktakeLine>[
      for (final Product p in MockData.products)
        StocktakeLine(
          product: p,
          systemQuantity: MockData.onHandAt(p.id, _branchId),
        ),
    ];
  }

  List<StocktakeLine> get visibleLines {
    final String q = _query.trim().toLowerCase();
    if (q.isEmpty) return _lines;
    return _lines
        .where((StocktakeLine l) =>
            l.product.name.toLowerCase().contains(q) ||
            l.product.sku.toLowerCase().contains(q) ||
            l.product.barcode.contains(q))
        .toList(growable: false);
  }

  int get countedCount =>
      _lines.where((StocktakeLine l) => l.isCounted).length;

  int get shortageCount =>
      _lines.where((StocktakeLine l) => l.isCounted && l.difference < 0).length;

  int get surplusCount =>
      _lines.where((StocktakeLine l) => l.isCounted && l.difference > 0).length;

  double get netValue => _lines
      .where((StocktakeLine l) => l.isCounted)
      .fold<double>(0, (double s, StocktakeLine l) => s + l.valueDifference);

  bool get hasCounted => countedCount > 0;

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void changeBranch(String id) {
    _branchId = id;
    _lines = _buildLines();
    notifyListeners();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setActualQuantity(StocktakeLine line, int? quantity) {
    line.actualQuantity = quantity;
    notifyListeners();
  }

  void fillAllFromSystem() {
    for (final StocktakeLine l in _lines) {
      l.actualQuantity = l.systemQuantity;
    }
    notifyListeners();
  }

  void resetAll() {
    for (final StocktakeLine l in _lines) {
      l.actualQuantity = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
