import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/return_line.dart';

/// حالة شاشة المرتجعات: الفاتورة المختارة والأصناف المحددة للإرجاع.
class ReturnsController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  SaleInvoice? _invoice;
  List<ReturnLine> _lines = <ReturnLine>[];
  String? _reason;
  String _refundMethod = MockData.refundMethods.first;
  String? _error;

  SaleInvoice? get invoice => _invoice;
  List<ReturnLine> get lines => _lines;
  String? get reason => _reason;
  String get refundMethod => _refundMethod;
  String? get error => _error;

  bool get hasInvoice => _invoice != null;

  List<ReturnLine> get selectedLines =>
      _lines.where((ReturnLine l) => l.selected).toList(growable: false);

  /// قيمة الـCheckbox في رأس الجدول (tristate).
  bool get allSelected => _lines.every((ReturnLine l) => l.selected);

  // ── حسابات الاسترداد ─────────────────────────────────────────────────────
  double get refundSubtotal => selectedLines.fold<double>(
        0,
        (double s, ReturnLine l) => s + l.refundAmount,
      );

  double get refundTax => refundSubtotal * MockData.taxRate;

  double get refundTotal => refundSubtotal + refundTax;

  int get returnedUnits => selectedLines.fold<int>(
        0,
        (int s, ReturnLine l) => s + l.returnQuantity,
      );

  bool get canSubmit => selectedLines.isNotEmpty && _reason != null;

  /// التنبيه اللي بيظهر تحت قائمة الأسباب.
  bool get needsReason => selectedLines.isNotEmpty && _reason == null;

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void search([String? value]) {
    final String query = (value ?? searchController.text).trim();
    if (query.isEmpty) return;

    final SaleInvoice? found = MockData.invoiceById(query);
    if (found == null) {
      _error = 'لا توجد فاتورة بالرقم «$query» — جرّب رقمًا آخر';
      _invoice = null;
      _lines = <ReturnLine>[];
    } else {
      _error = null;
      _invoice = found;
      _lines = <ReturnLine>[
        for (final InvoiceLine l in found.lines) ReturnLine(invoiceLine: l),
      ];
      _reason = null;
    }
    notifyListeners();
  }

  /// بيجيب أحدث فاتورة كمثال سريع للتجربة.
  void loadRecentInvoice() {
    final SaleInvoice invoice = MockData.salesInvoices.first;
    searchController.text = invoice.id;
    search(invoice.id);
  }

  void clear() {
    _invoice = null;
    _lines = <ReturnLine>[];
    _reason = null;
    _error = null;
    searchController.clear();
    searchFocus.requestFocus();
    notifyListeners();
  }

  void setReason(String? reason) {
    _reason = reason;
    notifyListeners();
  }

  void setRefundMethod(String method) {
    _refundMethod = method;
    notifyListeners();
  }

  void setLineSelected(ReturnLine line, bool selected) {
    line.selected = selected;
    notifyListeners();
  }

  void toggleLine(ReturnLine line) => setLineSelected(line, !line.selected);

  void setAllSelected(bool selected) {
    for (final ReturnLine l in _lines) {
      l.selected = selected;
    }
    notifyListeners();
  }

  /// مينفعش نرجّع أكتر من الكمية المباعة.
  void setReturnQuantity(ReturnLine line, int quantity) {
    line.returnQuantity = quantity.clamp(0, line.maxQuantity);
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }
}
