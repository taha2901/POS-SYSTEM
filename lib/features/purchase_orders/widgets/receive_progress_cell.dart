import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// شريط نسبة استلام صغير داخل جدول الأوامر.
class ReceiveProgressCell extends StatelessWidget {
  const ReceiveProgressCell({super.key, required this.ratio});

  final double ratio;

  @override
  Widget build(BuildContext context) {
    final int percent = (ratio * 100).round();
    final Color color = ratio >= 1
        ? AppColors.success
        : ratio > 0
            ? AppColors.warning
            : AppColors.textMuted;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$percent%',
          style: AppText.amountSm.copyWith(fontSize: 12.5, color: color),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: SizedBox(
            width: 110,
            height: 6,
            child: Stack(
              children: <Widget>[
                Container(color: AppColors.surfaceAlt),
                FractionallySizedBox(
                  widthFactor: ratio.clamp(0, 1),
                  child: Container(color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
