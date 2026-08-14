import '../../../mock_data/mock_data.dart';

/// صف مرتجع — بيحمل الكمية اللي هتترجّع من سطر الفاتورة.
class ReturnLine {
  ReturnLine({required this.invoiceLine});

  final InvoiceLine invoiceLine;
  bool selected = false;
  int returnQuantity = 1;

  Product get product => invoiceLine.product;
  int get maxQuantity => invoiceLine.quantity;
  double get refundAmount => invoiceLine.unitPrice * returnQuantity;
}
