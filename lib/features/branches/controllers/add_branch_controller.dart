import 'package:flutter/material.dart';

import '../models/draft_branch.dart';

/// حالة نموذج إضافة فرع.
class AddBranchController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController managerController = TextEditingController();

  bool get isValid =>
      nameController.text.trim().isNotEmpty &&
      addressController.text.trim().isNotEmpty;

  void fieldChanged([String? _]) => notifyListeners();

  /// بيبني الفرع المبدئي بالقيم المُدخلة.
  DraftBranch build() {
    final String manager = managerController.text.trim();

    return DraftBranch(
      name: nameController.text.trim(),
      address: addressController.text.trim(),
      manager: manager.isEmpty ? 'لم يتم التعيين' : manager,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    managerController.dispose();
    super.dispose();
  }
}
