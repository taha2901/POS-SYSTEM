import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/payment_controller.dart';
import 'payment_mini_action.dart';

/// خانة عرض المبلغ اللي بيتكتب على الـNumpad.
class PaymentAmountDisplay extends StatelessWidget {
  const PaymentAmountDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController payment = context.watch<PaymentController>();

    return Container(
      height: 74,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                payment.amountText,
                style: AppText.amountHero.copyWith(fontSize: 38),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            Fmt.currencySymbol,
            style: AppText.amountMd.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(width: AppSpacing.sm),
          PaymentMiniAction(
            icon: Icons.backspace_outlined,
            tooltip: 'مسح خانة',
            onTap: payment.backspace,
          ),
          const SizedBox(width: 6),
          PaymentMiniAction(
            icon: Icons.clear_rounded,
            tooltip: 'مسح الكل',
            onTap: payment.clearInput,
          ),
        ],
      ),
    );
  }
}
