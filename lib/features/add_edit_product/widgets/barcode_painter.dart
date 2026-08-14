import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// باركود Placeholder — خطوط عمودية بعرض متغيّر مشتق من الكود نفسه.
class BarcodePainter extends CustomPainter {
  const BarcodePainter({required this.seed});

  final String seed;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = AppColors.primary;

    int hash = 17;
    for (final int code in seed.codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }

    double x = 0;
    int i = 0;
    while (x < size.width - 2) {
      final int value = (hash >> (i % 24)) ^ (i * 7);
      final double barWidth = 1.0 + (value % 4);
      final bool filled = value % 3 != 0;

      if (filled) {
        canvas.drawRect(Rect.fromLTWH(x, 0, barWidth, size.height), paint);
      }
      x += barWidth + 1 + (value % 2);
      i++;
    }
  }

  @override
  bool shouldRepaint(BarcodePainter oldDelegate) => oldDelegate.seed != seed;
}
