import 'package:flutter/material.dart';

import '../../../core/widgets/app_data_table.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// خلية المنتج: أيقونة الفئة + الاسم والـSKU.
class StockProductCell extends StatelessWidget {
  const StockProductCell({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: product.accentColor.withValues(alpha: 0.12),
            borderRadius: AppRadius.smAll,
          ),
          child: Icon(
            product.categoryIcon,
            size: 18,
            color: product.accentColor,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: TableCells.twoLine(product.name, product.sku)),
      ],
    );
  }
}
