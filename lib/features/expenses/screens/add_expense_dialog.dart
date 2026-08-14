import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/add_expense_controller.dart';
import '../widgets/add_expense_actions.dart';
import '../widgets/add_expense_fields.dart';
import '../widgets/add_expense_header.dart';

/// يفتح حوار إضافة مصروف ويرجّع المصروف الجديد (أو null لو اتلغى).
Future<Expense?> showAddExpenseDialog(BuildContext context) {
  return showDialog<Expense>(
    context: context,
    builder: (BuildContext context) => const AddExpenseDialog(),
  );
}

/// حوار إضافة مصروف — بيجمّع الهيدر والحقول والأزرار بس.
class AddExpenseDialog extends StatelessWidget {
  const AddExpenseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddExpenseController>(
      create: (_) => AddExpenseController(),
      child: Dialog(
        child: SizedBox(
          width: 560,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AddExpenseHeader(),
                SizedBox(height: AppSpacing.xl),
                AddExpenseFields(),
                SizedBox(height: AppSpacing.xxl),
                AddExpenseActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
