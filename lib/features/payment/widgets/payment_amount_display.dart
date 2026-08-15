import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/payment_controller.dart';
import 'payment_mini_action.dart';

/// خانة المبلغ — بتتكتب بالـNumpad أو من كيبورد الجهاز.
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
            child: TextField(
              controller: payment.amountController,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              onChanged: payment.amountTyped,
              style: AppText.amountHero.copyWith(fontSize: 38),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: AppText.amountHero.copyWith(
                  fontSize: 38,
                  color: AppColors.textMuted,
                ),
                filled: false,
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
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
