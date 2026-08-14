import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// سطر في ملخّص المرتجع.
class ReturnsSummaryRow extends StatelessWidget {
  const ReturnsSummaryRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.body.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          value,
          maxLines: 1,
          style: AppText.amountSm.copyWith(fontSize: 13.5),
        ),
      ],
    );
  }
}
