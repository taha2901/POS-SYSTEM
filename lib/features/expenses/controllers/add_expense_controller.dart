import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';

/// حالة نموذج إضافة مصروف.
class AddExpenseController extends ChangeNotifier {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String _category = MockData.expenseCategories.first;
  String _branchId = MockData.branches.first.id;

  String get category => _category;
  String get branchId => _branchId;

  double get amount => double.tryParse(amountController.text.trim()) ?? 0;

  bool get isValid => amount > 0;

  void setCategory(String category) {
    _category = category;
    notifyListeners();
  }

  void setBranch(String id) {
    _branchId = id;
    notifyListeners();
  }

  void amountChanged([String? _]) => notifyListeners();

  /// بيبني المصروف الجديد بالقيم المُدخلة.
  Expense build() {
    final String note = noteController.text.trim();

    return Expense(
      id: 'EXP-${242 + DateTime.now().millisecond % 100}',
      date: MockData.today,
      category: _category,
      branchId: _branchId,
      amount: amount,
      status: ExpenseStatus.pending,
      note: note.isEmpty ? 'بدون ملاحظة' : note,
      createdBy: MockData.currentUser.name,
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }
}
