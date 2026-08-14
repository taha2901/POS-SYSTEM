import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// سطر في ملخّص اعتماد الجرد.
class StocktakeSummaryLine extends StatelessWidget {
  const StocktakeSummaryLine({
    super.key,
    required this.label,
    required this.value,
    this.color,
  });

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: <Widget>[
          Text(label, style: AppText.caption),
          const Spacer(),
          Text(value, style: AppText.amountSm.copyWith(color: color)),
        ],
      ),
    );
  }
}
