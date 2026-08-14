import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/product_form_controller.dart';

/// تنبيه بيوضّح إمتى هيظهر إشعار نقص المخزون.
class ReorderHintCard extends StatelessWidget {
  const ReorderHintCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductFormController form = context.watch<ProductFormController>();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.infoSoft,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: AppColors.info,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'هيوصلك تنبيه في شاشة المخزون لما الرصيد يقلّ عن '
              '${form.reorderPoint} ${form.unit}.',
              style: AppText.body.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
