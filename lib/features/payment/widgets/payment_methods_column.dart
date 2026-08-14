import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/payment_controller.dart';
import 'payment_entries_list.dart';
import 'payment_methods_grid.dart';

/// العمود اليمين في شاشة الدفع: اختيار الطريقة، الدفعات المسجّلة، والتقسيم.
class PaymentMethodsColumn extends StatelessWidget {
  const PaymentMethodsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController payment = context.watch<PaymentController>();
    final bool canSplit = payment.canSplit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('طريقة الدفع', style: AppText.label.copyWith(fontSize: 12.5)),
        const SizedBox(height: AppSpacing.md),
        const PaymentMethodsGrid(),
        const PaymentEntriesList(),
        const SizedBox(height: AppSpacing.lg),
        SecondaryButton(
          label: 'إضافة طريقة دفع أخرى',
          icon: Icons.add_rounded,
          tone: SecondaryButtonTone.accent,
          expanded: true,
          onPressed: canSplit ? payment.addAnotherMethod : null,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          canSplit
              ? 'المبلغ الحالي هيتسجّل كدفعة، والمتبقي هيتقسّم على طريقة تانية.'
              : 'قسّم الفاتورة على أكتر من طريقة دفع بإدخال مبلغ أقل من الإجمالي.',
          style: AppText.caption.copyWith(fontSize: 11.5),
        ),
      ],
    );
  }
}
