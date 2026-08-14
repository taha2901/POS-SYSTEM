import 'package:flutter/material.dart';

/// مراحل أمر التحويل.
enum TransferStatus { pending, inTransit, received }

extension TransferStatusInfo on TransferStatus {
  String get label => switch (this) {
        TransferStatus.pending => 'مُعلّق',
        TransferStatus.inTransit => 'في الطريق',
        TransferStatus.received => 'تم الاستلام',
      };

  IconData get icon => switch (this) {
        TransferStatus.pending => Icons.edit_note_rounded,
        TransferStatus.inTransit => Icons.local_shipping_rounded,
        TransferStatus.received => Icons.inventory_rounded,
      };

  /// نص زرار الإجراء في الفوتر حسب المرحلة.
  String get actionLabel => switch (this) {
        TransferStatus.pending => 'إرسال التحويل',
        TransferStatus.inTransit => 'تأكيد الاستلام',
        TransferStatus.received => 'إنهاء',
      };
}
