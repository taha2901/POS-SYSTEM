import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/held_invoice.dart';
import 'cart_controller.dart';

/// بيدير كل فواتير الكاشير المفتوحة في نفس الوقت + الفواتير المعلّقة.
///
/// كل تبويب [CartController] مستقل بالكامل (أصنافه وعميله وخصمه)،
/// والشاشة بتعرض الفاتورة النشطة بس.
class SalesSessionController extends ChangeNotifier {
  SalesSessionController() {
    _carts.add(CartController(number: _nextNumber++));
  }

  final List<CartController> _carts = <CartController>[];
  final List<HeldInvoice> _held = <HeldInvoice>[];

  int _activeIndex = 0;
  int _nextNumber = 1;
  int _nextHeldId = 1;

  UnmodifiableListView<CartController> get carts =>
      UnmodifiableListView<CartController>(_carts);

  UnmodifiableListView<HeldInvoice> get held =>
      UnmodifiableListView<HeldInvoice>(_held);

  int get activeIndex => _activeIndex;

  CartController get active => _carts[_activeIndex];

  int get heldCount => _held.length;

  /// آخر تبويب مبيتقفلش — لازم يفضل فيه فاتورة واحدة على الأقل.
  bool get canCloseTabs => _carts.length > 1;

  // ── التبويبات ────────────────────────────────────────────────────────────
  void switchTo(int index) {
    if (index < 0 || index >= _carts.length || index == _activeIndex) return;
    _activeIndex = index;
    notifyListeners();
  }

  void openNew() {
    _carts.add(CartController(number: _nextNumber++));
    _activeIndex = _carts.length - 1;
    notifyListeners();
  }

  void closeAt(int index) {
    if (!canCloseTabs || index < 0 || index >= _carts.length) return;

    _carts.removeAt(index).dispose();
    if (_activeIndex >= _carts.length) _activeIndex = _carts.length - 1;
    notifyListeners();
  }

  // ── التعليق والاسترجاع ───────────────────────────────────────────────────
  /// بيحفظ الفاتورة النشطة في المعلّقة ويقفل تبويبها.
  void holdActive() {
    if (active.isEmpty) return;

    _held.add(active.snapshot(_nextHeldId++));
    _closeOrClearActive();
    notifyListeners();
  }

  /// بيرجّع فاتورة معلّقة في تبويب جديد ويشيلها من القائمة.
  void restore(HeldInvoice invoice) {
    _held.remove(invoice);

    // لو التبويب الحالي فاضي بنستخدمه بدل ما نفتح تبويب زيادة
    if (active.isEmpty) {
      active.restoreFrom(invoice);
    } else {
      final CartController cart = CartController(number: _nextNumber++);
      cart.restoreFrom(invoice);
      _carts.add(cart);
      _activeIndex = _carts.length - 1;
    }
    notifyListeners();
  }

  void deleteHeld(HeldInvoice invoice) {
    _held.remove(invoice);
    notifyListeners();
  }

  /// بعد ما الفاتورة تتدفع — بيقفل تبويبها أو يفضّيه لو هو الأخير.
  void completeActive() {
    _closeOrClearActive();
    notifyListeners();
  }

  void _closeOrClearActive() {
    if (canCloseTabs) {
      _carts.removeAt(_activeIndex).dispose();
      if (_activeIndex >= _carts.length) _activeIndex = _carts.length - 1;
    } else {
      active.clear();
    }
  }

  @override
  void dispose() {
    for (final CartController c in _carts) {
      c.dispose();
    }
    super.dispose();
  }
}
