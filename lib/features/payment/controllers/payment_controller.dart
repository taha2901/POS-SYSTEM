import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../../core/widgets/numpad.dart';
import '../models/payment_entry.dart';
import '../models/payment_method.dart';
import '../models/payment_result.dart';

/// حالة شاشة الدفع: الدفعات المسجّلة، الطريقة الحالية، والمبلغ اللي بيتكتب.
class PaymentController extends ChangeNotifier {
  PaymentController({required this.total})
      : _entry = AmountEntry(initial: total);

  /// إجمالي الفاتورة المطلوب تحصيله.
  final double total;

  final List<PaymentEntry> _entries = <PaymentEntry>[];
  PaymentMethod _method = PaymentMethod.cash;

  /// المبلغ اللي بيتكتب دلوقتي على الـNumpad
  final AmountEntry _entry;

  UnmodifiableListView<PaymentEntry> get entries =>
      UnmodifiableListView<PaymentEntry>(_entries);

  PaymentMethod get method => _method;

  String get amountText => _entry.isEmpty ? '0' : _entry.text;

  // ── حسابات ───────────────────────────────────────────────────────────────
  double get committed =>
      _entries.fold<double>(0, (double s, PaymentEntry e) => s + e.amount);

  /// المتبقي قبل المبلغ اللي بيتكتب دلوقتي
  double get remainingBefore => total - committed;

  double get currentAmount => _entry.value;

  double get paid => committed + currentAmount;

  /// موجب = لسه فاضل، سالب = الباقي للعميل
  double get remainingAfter => total - paid;

  double get change => remainingAfter < 0 ? -remainingAfter : 0;

  bool get isCovered => remainingAfter <= 0.005;

  bool get canSplit =>
      currentAmount > 0 && remainingAfter > 0.005 && _entries.length < 3;

  bool isUsed(PaymentMethod method) =>
      _entries.any((PaymentEntry e) => e.method == method);

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void tapKey(String key) {
    _entry.tapKey(key);
    notifyListeners();
  }

  void backspace() {
    _entry.backspace();
    notifyListeners();
  }

  void clearInput() {
    _entry.clear();
    notifyListeners();
  }

  void addQuick(double value) {
    _entry.add(value);
    notifyListeners();
  }

  void setExact() {
    _entry.setValue(remainingBefore);
    notifyListeners();
  }

  void selectMethod(PaymentMethod method) {
    _method = method;
    // الآجل بياخد المتبقي كله على حساب العميل
    if (method == PaymentMethod.credit) {
      _entry.setValue(remainingBefore);
    }
    notifyListeners();
  }

  /// يثبّت المبلغ الحالي كدفعة ويفتح دفعة جديدة بالمتبقي.
  void addAnotherMethod() {
    final double amount = currentAmount.clamp(0, remainingBefore);
    if (amount <= 0) return;

    _entries.add(PaymentEntry(method: _method, amount: amount));
    _method = _nextUnusedMethod();
    _entry.setValue(remainingBefore);
    notifyListeners();
  }

  void removeEntry(int index) {
    _entries.removeAt(index);
    _entry.setValue(remainingBefore);
    notifyListeners();
  }

  PaymentMethod _nextUnusedMethod() {
    final Set<PaymentMethod> used =
        _entries.map((PaymentEntry e) => e.method).toSet();
    for (final PaymentMethod m in PaymentMethod.values) {
      if (!used.contains(m)) return m;
    }
    return PaymentMethod.cash;
  }

  /// النتيجة النهائية — المبلغ اللي على الشاشة بيتحسب كدفعة أخيرة.
  PaymentResult buildResult() {
    return PaymentResult(
      entries: <PaymentEntry>[
        ..._entries,
        if (currentAmount > 0)
          PaymentEntry(method: _method, amount: currentAmount),
      ],
      total: total,
      paid: paid,
      change: change,
    );
  }
}
