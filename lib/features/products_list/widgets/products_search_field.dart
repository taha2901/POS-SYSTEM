import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/products_list_controller.dart';

/// خانة البحث بالاسم أو الـSKU أو الباركود.
class ProductsSearchField extends StatelessWidget {
  const ProductsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsListController products =
        context.watch<ProductsListController>();

    return SizedBox(
      width: 280,
      height: 46,
      child: TextField(
        controller: products.searchController,
        onChanged: products.setQuery,
        style: AppText.body.copyWith(fontSize: 13.5),
        decoration: InputDecoration(
          hintText: 'ابحث بالاسم أو SKU أو الباركود…',
          hintStyle: AppText.body.copyWith(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
          prefixIcon: const Icon(Icons.search_rounded, size: 19),
          suffixIcon: products.query.isEmpty
              ? null
              : IconButton(
                  tooltip: 'مسح',
                  icon: const Icon(Icons.close_rounded, size: 17),
                  onPressed: products.clearSearch,
                ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
        ),
      ),
    );
  }
}
