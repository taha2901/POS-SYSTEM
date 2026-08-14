import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// شريط نسبة أفقي بحواف دائرية — الشكل الموحّد لكل أشرطة التقدّم.
class ProgressTrack extends StatelessWidget {
  const ProgressTrack({
    super.key,
    required this.ratio,
    this.height = 6,
    this.background = AppColors.surfaceAlt,
    this.color,
    this.gradient,
  }) : assert(
          color != null || gradient != null,
          'لازم تمرّر color أو gradient',
        );

  /// من 0 لـ1 — أي قيمة برّه المدى بتتقصّ.
  final double ratio;
  final double height;
  final Color background;
  final Color? color;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(color: background),
            FractionallySizedBox(
              widthFactor: ratio.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(color: color, gradient: gradient),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
