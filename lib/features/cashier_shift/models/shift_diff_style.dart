import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// شكل بطاقة الفرق: أحمر لو عجز، أخضر لو مطابق تمامًا، وبرتقالي لو فيه زيادة.
class ShiftDiffStyle {
  const ShiftDiffStyle({
    required this.color,
    required this.background,
    required this.label,
    required this.icon,
  });

  /// [difference] بيتحسب بس لو الكاشير دخّل العدّ الفعلي.
  factory ShiftDiffStyle.of({
    required bool isCounted,
    required double difference,
  }) {
    if (!isCounted) {
      return const ShiftDiffStyle(
        color: AppColors.textMuted,
        background: AppColors.surfaceAlt,
        label: 'في انتظار العدّ',
        icon: Icons.hourglass_empty_rounded,
      );
    }
    if (difference < -0.005) {
      return const ShiftDiffStyle(
        color: AppColors.danger,
        background: AppColors.dangerSoft,
        label: 'عجز في الدرج',
        icon: Icons.trending_down_rounded,
      );
    }
    if (difference > 0.005) {
      return const ShiftDiffStyle(
        color: AppColors.warning,
        background: AppColors.warningSoft,
        label: 'زيادة في الدرج',
        icon: Icons.trending_up_rounded,
      );
    }
    return const ShiftDiffStyle(
      color: AppColors.success,
      background: AppColors.successSoft,
      label: 'مطابق تمامًا',
      icon: Icons.check_circle_outline_rounded,
    );
  }

  final Color color;
  final Color background;
  final String label;
  final IconData icon;
}
