import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// خلية طريقة الدفع في سجل الفواتير.
class InvoicePaymentMethodCell extends StatelessWidget {
  const InvoicePaymentMethodCell({super.key, required this.method});

  final String method;

  IconData get _icon => switch (method) {
        'نقدي' => Icons.payments_outlined,
        'بطاقة' => Icons.credit_card_rounded,
        'محفظة' => Icons.account_balance_wallet_outlined,
        _ => Icons.schedule_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(_icon, size: 15, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(method, style: AppText.body.copyWith(fontSize: 13)),
      ],
    );
  }
}
