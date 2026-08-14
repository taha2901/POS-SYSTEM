import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// عنوان صغير فوق مبلغ — بيتكرر في فوتر الدفع وشاشة النجاح.
class PaymentStat extends StatelessWidget {
  const PaymentStat({
    super.key,
    required this.label,
    required this.value,
    required this.valueStyle,
    this.labelSize = 12,
    this.alignment = CrossAxisAlignment.start,
  });

  final String label;
  final String value;
  final TextStyle valueStyle;
  final double labelSize;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label, style: AppText.label.copyWith(fontSize: labelSize)),
        const SizedBox(height: 2),
        Text(value, style: valueStyle),
      ],
    );
  }
}
