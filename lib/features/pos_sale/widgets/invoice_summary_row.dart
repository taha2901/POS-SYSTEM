import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// صف واحد في ملخص الفاتورة (المجموع الفرعي / الخصم / الضريبة).
class InvoiceSummaryRow extends StatelessWidget {
  const InvoiceSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: AppText.body.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13.5,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppText.amountSm.copyWith(
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
