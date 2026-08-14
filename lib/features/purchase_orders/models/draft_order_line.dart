import '../../../mock_data/mock_data.dart';

/// صف في أمر الشراء الجديد.
class DraftOrderLine {
  DraftOrderLine({
    required this.product,
    required this.quantity,
    required this.unitCost,
  });

  final Product product;
  int quantity;
  double unitCost;

  double get total => quantity * unitCost;
}
