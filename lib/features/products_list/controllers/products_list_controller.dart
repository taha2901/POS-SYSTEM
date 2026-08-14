import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/products_filter.dart';
import '../models/products_sort_column.dart';

/// حالة شاشة المنتجات: البحث، الفئة، التبويب المختار، والفرز.
class ProductsListController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  String _query = '';
  String? _categoryId;
  ProductsFilter _filter = ProductsFilter.all;
  int _sortIndex = 0;
  bool _sortAscending = true;

  /// نتيجة الفلترة والفرز — بتتحسب مرة واحدة لحد ما حاجة تتغيّر.
  List<Product>? _cachedRows;

  String get query => _query;
  String? get categoryId => _categoryId;
  ProductsFilter get filter => _filter;
  int get sortIndex => _sortIndex;
  bool get sortAscending => _sortAscending;

  List<Product> get rows => _cachedRows ??= _computeRows();

  int get visibleCount => rows.length;

  double get visibleValue =>
      rows.fold<double>(0, (double s, Product p) => s + p.price * p.stock);

  // ── الفلترة والفرز ───────────────────────────────────────────────────────
  List<Product> _computeRows() {
    Iterable<Product> items = MockData.searchProducts(
      _query,
      categoryId: _categoryId,
    );

    items = switch (_filter) {
      ProductsFilter.all => items,
      ProductsFilter.lowStock =>
        items.where((Product p) => p.isLowStock || p.isOutOfStock),
      ProductsFilter.inactive => items.where((Product p) => !p.isActive),
    };

    final List<Product> list = items.toList();
    final ProductsSortColumn column = ProductsSortColumn.values[_sortIndex];

    list.sort((Product a, Product b) {
      final int result = switch (column) {
        ProductsSortColumn.name => a.name.compareTo(b.name),
        ProductsSortColumn.sku => a.sku.compareTo(b.sku),
        ProductsSortColumn.category => a.categoryName.compareTo(b.categoryName),
        ProductsSortColumn.price => a.price.compareTo(b.price),
        ProductsSortColumn.stock => a.stock.compareTo(b.stock),
        ProductsSortColumn.status => _statusRank(a).compareTo(_statusRank(b)),
      };
      return _sortAscending ? result : -result;
    });

    return list;
  }

  int _statusRank(Product p) {
    if (!p.isActive) return 3;
    if (p.isOutOfStock) return 0;
    if (p.isLowStock) return 1;
    return 2;
  }

  int countFor(ProductsFilter filter) => switch (filter) {
        ProductsFilter.all => MockData.products.length,
        ProductsFilter.lowStock =>
          MockData.lowStockProducts.length + MockData.outOfStockProducts.length,
        ProductsFilter.inactive => MockData.inactiveProducts.length,
      };

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void setQuery(String value) {
    _query = value;
    _refresh();
  }

  void clearSearch() {
    searchController.clear();
    setQuery('');
  }

  void setCategory(String? id) {
    _categoryId = id;
    _refresh();
  }

  void setFilter(ProductsFilter filter) {
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
