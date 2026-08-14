import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// النص في منتصف رسم طرق الدفع.
class PaymentPieCenter extends StatelessWidget {
  const PaymentPieCenter({
    super.key,
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(value, style: AppText.amountLg.copyWith(fontSize: 19)),
        const SizedBox(height: 2),
        Text(label, style: AppText.caption.copyWith(fontSize: 11)),
      ],
    );
  }
}
