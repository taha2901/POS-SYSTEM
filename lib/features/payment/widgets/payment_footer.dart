import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/payment_controller.dart';
import 'payment_stat.dart';

/// فوتر شاشة الدفع: المدفوع، الباقي، وزرار التأكيد.
class PaymentFooter extends StatelessWidget {
  const PaymentFooter({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final PaymentController payment = context.watch<PaymentController>();
    final bool covered = payment.isCovered;
    final double change = payment.change;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
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
          PaymentStat(
            label: 'إجمالي المدفوع',
            value: Fmt.money(payment.paid),
            valueStyle: AppText.amountLg.copyWith(
              fontSize: 20,
              color: covered ? AppColors.success : AppColors.textPrimary,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            color: AppColors.border,
          ),
          // الباقي — بخط كبير وأخضر
          PaymentStat(
            label: 'الباقي للعميل',
            value: Fmt.money(change),
            valueStyle: AppText.amountHero.copyWith(
              fontSize: 28,
              color: change > 0.005
                  ? AppColors.success
                  : AppColors.textMuted,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: PrimaryButton(
              label: 'تأكيد الدفع',
              icon: Icons.check_circle_outline_rounded,
              size: AppButtonSize.hero,
              expanded: true,
              onPressed: covered ? onConfirm : null,
            ),
          ),
        ],
      ),
    );
  }
}
