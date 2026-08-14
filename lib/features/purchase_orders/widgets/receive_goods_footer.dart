import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/receive_goods_controller.dart';

/// فوتر حوار الاستلام: قيمة الاستلام وأزرار التصفير والاستلام.
class ReceiveGoodsFooter extends StatelessWidget {
  const ReceiveGoodsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final ReceiveGoodsController receive =
        context.watch<ReceiveGoodsController>();
    final bool isComplete = receive.isComplete;

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.xl),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppRadius.xl),
          bottomLeft: Radius.circular(AppRadius.xl),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'قيمة الاستلام الحالي',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.label.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    Fmt.money(receive.receivingValue),
                    style: AppText.amountLg,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          SecondaryButton(label: 'تصفير', onPressed: receive.clearAll),
          const SizedBox(width: AppSpacing.sm),
          SecondaryButton(
            label: 'استلام الكل',
            icon: Icons.done_all_rounded,
            tone: SecondaryButtonTone.accent,
            onPressed: receive.receiveAll,
          ),
          const SizedBox(width: AppSpacing.md),
          PrimaryButton(
            label: isComplete ? 'إتمام الاستلام' : 'تسجيل استلام جزئي',
            icon: Icons.check_circle_outline_rounded,
            size: AppButtonSize.large,
            color: isComplete ? AppColors.success : null,
            onPressed: receive.canSubmit
                ? () => Navigator.of(context).pop(true)
                : null,
          ),
        ],
      ),
    );
  }
}
