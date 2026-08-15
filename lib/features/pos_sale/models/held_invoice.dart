import '../../../mock_data/mock_data.dart';
import 'cart_discount.dart';
import 'cart_line.dart';

/// فاتورة معلّقة — نسخة محفوظة من السلة يقدر الكاشير يرجّعها وقت ما يحب.
class HeldInvoice {
  HeldInvoice({
    required this.id,
    required this.lines,
    required this.customer,
    required this.discount,
    required this.heldAt,
  });

  final int id;
  final List<CartLine> lines;
  final Customer customer;
  final CartDiscount discount;
  final DateTime heldAt;

  int get itemsCount =>
      lines.fold<int>(0, (int sum, CartLine l) => sum + l.quantity);

  double get subtotal =>
      lines.fold<double>(0, (double sum, CartLine l) => sum + l.total);
}
