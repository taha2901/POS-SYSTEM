import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/products_list_controller.dart';
import '../widgets/products_filter_tabs.dart';
import '../widgets/products_list_header.dart';
import '../widgets/products_table.dart';

/// شاشة المنتجات — بتجمّع الهيدر والتبويبات والجدول بس.
class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductsListController>(
      create: (_) => ProductsListController(),
      child: Padding(
        padding: AppSpacing.page,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ProductsListHeader(),
            SizedBox(height: AppSpacing.xl),
            ProductsFilterTabs(),
            SizedBox(height: AppSpacing.lg),
            Expanded(child: ProductsTable()),
          ],
        ),
      ),
    );
  }
}
