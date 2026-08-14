import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'payment_amount_column.dart';
import 'payment_methods_column.dart';

/// جسم شاشة الدفع: عمود الطرق وعمود المبلغ جنب بعض.
class PaymentBody extends StatelessWidget {
  const PaymentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Expanded(flex: 5, child: PaymentMethodsColumn()),
          const SizedBox(width: AppSpacing.xl),
          // الفاصل جزء من عمود الـNumpad عشان ياخد ارتفاعه الطبيعي
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsetsDirectional.only(start: AppSpacing.xl),
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  start: BorderSide(color: AppColors.border),
                ),
              ),
              child: const PaymentAmountColumn(),
            ),
          ),
        ],
      ),
    );
  }
}
