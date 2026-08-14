import '../../../mock_data/mock_data.dart';

/// صف استلام — بيحمل الكمية اللي بتتستلم دلوقتي.
class ReceiveLine {
  ReceiveLine({required this.orderLine, int? receivingNow})
      : receivingNow = receivingNow ?? orderLine.remaining;

  final PurchaseOrderLine orderLine;
  int receivingNow;

  int get ordered => orderLine.quantity;
  int get previouslyReceived => orderLine.receivedQuantity;
  int get totalAfter => previouslyReceived + receivingNow;
  int get remainingAfter => ordered - totalAfter;

  double get receivingValue => receivingNow * orderLine.unitCost;
}
