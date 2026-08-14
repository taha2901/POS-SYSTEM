import '../../../mock_data/mock_data.dart';

/// صف منتج داخل أمر التحويل.
class TransferLine {
  TransferLine({required this.product, this.quantity = 1});

  final Product product;
  int quantity;

  double get value => product.cost * quantity;
}
