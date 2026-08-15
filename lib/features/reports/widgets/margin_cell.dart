import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// خلية هامش الربح بلون حسب قوّته.
class MarginCell extends StatelessWidget {
  const MarginCell({super.key, required this.margin});

  final double margin;

  @override
  Widget build(BuildContext context) {
    final Color color = margin >= 30
        ? AppColors.success
        : margin >= 18
            ? AppColors.warning
            : AppColors.danger;

    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: color.withValues(alpha: 0.22)),
          ),
          child: Text(
            Fmt.percent(margin),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
