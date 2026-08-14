import '../../mock_data/mock_data.dart';
import '../widgets/status_badge.dart';

/// لون الـBadge حسب حالة أمر الشراء:
/// رمادي = مسودة، أزرق = مؤكد، برتقالي = مستلم جزئيًا، أخضر = مكتمل
///
/// مشتركة بين شاشة أوامر الشراء وملف المورد.
extension PurchaseOrderStatusTone on PurchaseOrderStatus {
  StatusTone get tone => switch (this) {
        PurchaseOrderStatus.draft => StatusTone.neutral,
        PurchaseOrderStatus.confirmed => StatusTone.info,
        PurchaseOrderStatus.partiallyReceived => StatusTone.warning,
        PurchaseOrderStatus.completed => StatusTone.success,
      };
}
