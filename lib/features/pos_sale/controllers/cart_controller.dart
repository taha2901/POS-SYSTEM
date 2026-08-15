import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../../mock_data/mock_data.dart';
import '../models/cart_discount.dart';
import '../models/cart_line.dart';
import '../models/held_invoice.dart';

/// حالة السلة كاملة: الأصناف، الكميات، العميل، الخصم، وحسابات الفاتورة.
class CartController extends ChangeNotifier {
  CartController({required this.number});

  /// رقم الفاتورة في التبويبات — بيتعرض للكاشير عشان يفرّق بينها.
  final int number;

  final List<CartLine> _lines = <CartLine>[];
  Customer _customer = MockData.walkInCustomer;
  CartDiscount _discount = const CartDiscount.none();

  UnmodifiableListView<CartLine> get lines => UnmodifiableListView<CartLine>(
        _lines,
      );

  Customer get customer => _customer;
  CartDiscount get discount => _discount;
  bool get isEmpty => _lines.isEmpty;
  bool get isNotEmpty => _lines.isNotEmpty;

  // ── حسابات الفاتورة ──────────────────────────────────────────────────────
  double get subtotal =>
      _lines.fold<double>(0, (double sum, CartLine l) => sum + l.total);

  /// الخصم بالجنيه — مهما كان نوعه، ومش بيعدّي المجموع الفرعي.
  double get effectiveDiscount =>
      _discount.amountFor(subtotal).clamp(0, subtotal);

  double get taxableAmount => subtotal - effectiveDiscount;

  double get tax => taxableAmount * MockData.taxRate;

  double get total => taxableAmount + tax;

  int get itemsCount =>
      _lines.fold<int>(0, (int sum, CartLine l) => sum + l.quantity);

  // ── إجراءات ──────────────────────────────────────────────────────────────
  /// بيرجّع false لو المنتج نافد — الواجهة هي اللي بتعرض التنبيه.
  bool addProduct(Product product) {
    if (product.isOutOfStock) return false;

    final int index =
        _lines.indexWhere((CartLine l) => l.product.id == product.id);
    if (index == -1) {
      _lines.insert(0, CartLine(product: product));
    } else {
      _lines[index].quantity++;
    }
    notifyListeners();
    return true;
  }

  void changeQuantity(CartLine line, int delta) {
    final int next = line.quantity + delta;
    if (next <= 0) {
      _lines.remove(line);
    } else {
      line.quantity = next;
    }
    notifyListeners();
  }

  void removeLine(CartLine line) {
    _lines.remove(line);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    _discount = const CartDiscount.none();
    notifyListeners();
  }

  void setCustomer(Customer customer) {
    _customer = customer;
    notifyListeners();
  }

  void setDiscount(CartDiscount discount) {
    _discount = discount;
    notifyListeners();
  }

  /// نسخة من السلة عشان تتحفظ في الفواتير المعلّقة.
  HeldInvoice snapshot(int id) {
    return HeldInvoice(
      id: id,
      lines: <CartLine>[
        for (final CartLine l in _lines)
          CartLine(product: l.product, quantity: l.quantity),
      ],
      customer: _customer,
      discount: _discount,
      heldAt: DateTime.now(),
    );
  }

  /// بيملا السلة من فاتورة معلّقة اترجّعت.
  void restoreFrom(HeldInvoice invoice) {
    _lines
      ..clear()
      ..addAll(<CartLine>[
        for (final CartLine l in invoice.lines)
          CartLine(product: l.product, quantity: l.quantity),
      ]);
    _customer = invoice.customer;
    _discount = invoice.discount;
    notifyListeners();
  }
}
