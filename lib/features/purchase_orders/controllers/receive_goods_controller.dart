import 'package:flutter/foundation.dart';

import '../../../mock_data/mock_data.dart';
import '../models/receive_line.dart';

/// حالة الاستلام الجزئي: الكمية اللي بتتستلم دلوقتي من كل صنف.
class ReceiveGoodsController extends ChangeNotifier {
  ReceiveGoodsController({required this.order})
      : lines = <ReceiveLine>[
          for (final PurchaseOrderLine l in order.lines)
            ReceiveLine(orderLine: l),
        ];

  final PurchaseOrder order;
  final List<ReceiveLine> lines;

  int get orderedTotal => order.totalQuantity;

  int get receivedTotal =>
      lines.fold<int>(0, (int s, ReceiveLine l) => s + l.totalAfter);

  double get progress =>
      orderedTotal == 0 ? 0 : (receivedTotal / orderedTotal).clamp(0, 1);

  double get receivingValue =>
      lines.fold<double>(0, (double s, ReceiveLine l) => s + l.receivingValue);

  bool get isComplete => receivedTotal >= orderedTotal;

  bool get canSubmit => receivingValue > 0;

  /// مينفعش نستلم أكتر من المتبقي.
  void setReceivingNow(ReceiveLine line, int quantity) {
    line.receivingNow = quantity.clamp(0, line.orderLine.remaining);
    notifyListeners();
  }

  void receiveAll() {
    for (final ReceiveLine l in lines) {
      l.receivingNow = l.orderLine.remaining;
    }
    notifyListeners();
  }

  void clearAll() {
    for (final ReceiveLine l in lines) {
      l.receivingNow = 0;
    }
    notifyListeners();
  }
}
