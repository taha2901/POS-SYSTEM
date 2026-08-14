import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// نقطة ملوّنة باسمها في مفتاح الرسم البياني.
class ChartLegendDot extends StatelessWidget {
  const ChartLegendDot({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: AppText.caption.copyWith(fontSize: 11.5)),
      ],
    );
  }
}
