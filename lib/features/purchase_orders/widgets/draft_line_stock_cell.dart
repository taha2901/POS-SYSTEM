import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// خلية المخزون الحالي — حمرا لو الرصيد وصل لنقطة إعادة الطلب.
class DraftLineStockCell extends StatelessWidget {
  const DraftLineStockCell({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          Fmt.count(product.stock),
          style: AppText.amountSm.copyWith(
            fontSize: 13,
            color: product.stock <= product.minStock
                ? AppColors.danger
                : AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 4),
        Text(product.unit, style: AppText.caption.copyWith(fontSize: 11)),
      ],
    );
  }
}
