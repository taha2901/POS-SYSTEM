import 'package:flutter/material.dart';

import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// نغمة الـBadge حسب حالة العرض.
extension PromotionStatusTone on PromotionStatus {
  StatusTone get tone => switch (this) {
        PromotionStatus.active => StatusTone.success,
        PromotionStatus.scheduled => StatusTone.info,
        PromotionStatus.expired => StatusTone.neutral,
      };

  /// اللون المستخدم في شرائح الفلترة.
  Color get pillColor => switch (tone) {
        StatusTone.success => AppColors.success,
        StatusTone.info => AppColors.info,
        _ => AppColors.textSecondary,
      };
}
