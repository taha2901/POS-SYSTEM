import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/products_list_controller.dart';
import '../models/products_filter.dart';
import 'products_filter_tab.dart';

/// شريط التبويبات فوق الجدول (الكل / منخفضة المخزون / غير نشطة).
class ProductsFilterTabs extends StatelessWidget {
  const ProductsFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsListController products =
        context.watch<ProductsListController>();

    return Container(
      height: 48,
      padding: const EdgeInsets.all(5),
      decoration: AppDecorations.card(radius: AppRadius.md),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final ProductsFilter f in ProductsFilter.values) ...<Widget>[
            ProductsFilterTab(
              label: f.label,
              icon: f.icon,
              count: products.countFor(f),
              selected: products.filter == f,
              onTap: () => products.setFilter(f),
            ),
            const SizedBox(width: 4),
          ],
        ],
      ),
    );
  }
}
