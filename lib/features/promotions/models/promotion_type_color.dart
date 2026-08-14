import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// لون مميّز لكل نوع عرض.
extension PromotionTypeColor on PromotionType {
  Color get color => switch (this) {
        PromotionType.percentage => AppColors.accent,
        PromotionType.buyXGetY => const Color(0xFFEC4899),
        PromotionType.quantityDiscount => const Color(0xFF0EA5E9),
      };

  /// اللاحقة اللي بتظهر جنب قيمة الخصم في الفورم.
  String get valueSuffix => switch (this) {
        PromotionType.percentage => '%',
        PromotionType.buyXGetY => 'قطعة مجانية',
        PromotionType.quantityDiscount => 'ج.م',
      };

  String get valueHint => switch (this) {
        PromotionType.percentage => 'مثال: 15',
        PromotionType.buyXGetY => 'مثال: 1 (اشترِ 2 واحصل على 1)',
        PromotionType.quantityDiscount => 'مثال: 50',
      };
}
