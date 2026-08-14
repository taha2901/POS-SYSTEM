import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../mock_data/mock_data.dart';
import '../../../utils/formatters.dart';
import '../controllers/products_list_controller.dart';

/// قائمة اختيار الفئة — مع عدد المنتجات جنب كل فئة.
class ProductsCategoryDropdown extends StatelessWidget {
  const ProductsCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsListController products =
        context.watch<ProductsListController>();

    return AppDropdown<String?>(
      value: products.categoryId,
      width: 200,
      icon: Icons.category_outlined,
      onChanged: products.setCategory,
      items: <AppDropdownItem<String?>>[
        AppDropdownItem<String?>(
          value: null,
          label: 'كل الفئات',
          icon: Icons.apps_rounded,
          trailing: Fmt.count(MockData.products.length),
        ),
        for (final ProductCategory c in MockData.categories)
          AppDropdownItem<String?>(
            value: c.id,
            label: c.name,
            icon: c.icon,
            trailing: Fmt.count(MockData.productsByCategory(c.id).length),
          ),
      ],
    );
  }
}
