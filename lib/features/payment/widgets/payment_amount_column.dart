import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/numpad.dart';
import '../../../theme/app_theme.dart';
import '../controllers/payment_controller.dart';
import 'payment_amount_display.dart';
import 'payment_method_hint_row.dart';
import 'payment_quick_amounts.dart';

/// العمود الشمال في شاشة الدفع: إدخال المبلغ والـNumpad.
class PaymentAmountColumn extends StatelessWidget {
  const PaymentAmountColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController payment = context.read<PaymentController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const PaymentMethodHintRow(),
        const SizedBox(height: AppSpacing.md),
        const PaymentAmountDisplay(),
        const SizedBox(height: AppSpacing.md),
        const PaymentQuickAmounts(),
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: Numpad(
            keySize: 62,
            spacing: AppSpacing.md - 2,
            onKey: payment.tapKey,
            onBackspace: payment.backspace,
          ),
        ),
      ],
    );
  }
}
