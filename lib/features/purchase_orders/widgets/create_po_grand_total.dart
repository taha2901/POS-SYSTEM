import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/create_purchase_order_controller.dart';

/// إجمالي الأمر بخط بارز.
class CreatePoGrandTotal extends StatelessWidget {
  const CreatePoGrandTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final CreatePurchaseOrderController draft =
        context.watch<CreatePurchaseOrderController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('إجمالي الأمر', style: AppText.label.copyWith(fontSize: 12)),
        const SizedBox(height: 2),
        Text(
          Fmt.money(draft.total),
          style: AppText.amountHero.copyWith(
            fontSize: 30,
            color: draft.hasLines
                ? AppColors.textPrimary
                : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
