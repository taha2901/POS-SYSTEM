import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';

/// نغمة الـBadge حسب مجموعة العميل.
extension CustomerTierTone on CustomerTier {
  StatusTone get tone => switch (this) {
        CustomerTier.gold => StatusTone.warning,
        CustomerTier.silver => StatusTone.info,
        CustomerTier.regular => StatusTone.neutral,
      };

  /// الاسم المختصر المستخدم في فلتر المجموعات.
  String get shortLabel => switch (this) {
        CustomerTier.gold => 'ذهبي',
        CustomerTier.silver => 'فضي',
        CustomerTier.regular => 'عادي',
      };
}
