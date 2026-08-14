import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/products_list_controller.dart';

/// فوتر الجدول: إجمالي قيمة المعروض وعدد الصفوف.
class ProductsTableFooter extends StatelessWidget {
  const ProductsTableFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsListController products =
        context.watch<ProductsListController>();

    return Row(
      children: <Widget>[
        Text(
          'إجمالي قيمة المنتجات المعروضة: '
          '${Fmt.money(products.visibleValue)}',
          style: AppText.caption,
        ),
        const Spacer(),
        Text(
          '${Fmt.count(products.visibleCount)} صف',
          style: AppText.caption,
        ),
      ],
    );
  }
}
