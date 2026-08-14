import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../../mock_data/mock_data.dart';
import '../models/transfer_line.dart';
import '../models/transfer_status.dart';

/// حالة أمر تحويل المخزون: الفرعين، الأصناف، ومرحلة الشحنة.
class StockTransferController extends ChangeNotifier {
  String _fromBranchId = MockData.branches.first.id;
  String _toBranchId = MockData.branches[1].id;
  TransferStatus _status = TransferStatus.pending;
  final List<TransferLine> _lines = <TransferLine>[];

  String get fromBranchId => _fromBranchId;
  String get toBranchId => _toBranchId;
  TransferStatus get status => _status;

  UnmodifiableListView<TransferLine> get lines =>
      UnmodifiableListView<TransferLine>(_lines);

  Branch get from => MockData.branchById(_fromBranchId)!;
  Branch get to => MockData.branchById(_toBranchId)!;

  /// التعديل مسموح في مرحلة «مُعلّق» بس.
  bool get isEditable => _status == TransferStatus.pending;

  bool get sameBranch => _fromBranchId == _toBranchId;

  bool get canSubmit => _lines.isNotEmpty && !sameBranch;

  int get totalQuantity =>
      _lines.fold<int>(0, (int s, TransferLine l) => s + l.quantity);

  double get totalValue =>
      _lines.fold<double>(0, (double s, TransferLine l) => s + l.value);

  /// المنتجات المضافة بالفعل — عشان ما تتكررش في نافذة الاختيار.
  Set<String> get pickedProductIds =>
      _lines.map((TransferLine l) => l.product.id).toSet();

  /// الرصيد المتاح للمنتج في الفرع المُرسِل.
  int availableFor(Product product) =>
      MockData.availableAt(product.id, _fromBranchId);

  bool exceedsAvailable(TransferLine line) =>
      line.quantity > availableFor(line.product);

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void setFromBranch(String id) {
    _fromBranchId = id;
    notifyListeners();
  }

  void setToBranch(String id) {
    _toBranchId = id;
    notifyListeners();
  }

  void swapBranches() {
    final String temp = _fromBranchId;
    _fromBranchId = _toBranchId;
    _toBranchId = temp;
    notifyListeners();
  }

  void addProduct(Product product) {
    _lines.add(TransferLine(product: product));
    notifyListeners();
  }

  void removeLine(TransferLine line) {
    _lines.remove(line);
    notifyListeners();
  }

  void setQuantity(TransferLine line, int quantity) {
    line.quantity = quantity;
    notifyListeners();
  }

  /// ينقل الأمر للمرحلة اللي بعدها — بيرجّع true لو الأمر خلص.
  bool advance() {
    if (_status == TransferStatus.received) return true;

    _status = _status == TransferStatus.pending
        ? TransferStatus.inTransit
        : TransferStatus.received;
    notifyListeners();
    return false;
  }
}
