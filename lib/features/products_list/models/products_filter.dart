import 'package:flutter/material.dart';

/// التبويبات الصغيرة فوق جدول المنتجات.
enum ProductsFilter { all, lowStock, inactive }

extension ProductsFilterInfo on ProductsFilter {
  String get label => switch (this) {
        ProductsFilter.all => 'الكل',
        ProductsFilter.lowStock => 'منخفضة المخزون',
        ProductsFilter.inactive => 'غير نشطة',
      };

  IconData get icon => switch (this) {
        ProductsFilter.all => Icons.apps_rounded,
        ProductsFilter.lowStock => Icons.trending_down_rounded,
        ProductsFilter.inactive => Icons.visibility_off_outlined,
      };
}
