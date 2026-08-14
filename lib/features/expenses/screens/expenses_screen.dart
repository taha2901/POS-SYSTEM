import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/expenses_controller.dart';
import '../widgets/expenses_filter_bar.dart';
import '../widgets/expenses_stat_cards.dart';
import '../widgets/expenses_table.dart';
import 'add_expense_dialog.dart';

/// شاشة المصروفات — بتجمّع البطاقات وشريط الفلترة والجدول بس.
class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  Future<void> _addExpense(BuildContext context) async {
    final ExpensesController expenses = context.read<ExpensesController>();

    final Expense? created = await showAddExpenseDialog(context);
    if (created == null || !context.mounted) return;

    expenses.addExpense(created);
    showPlainSnackBar(
      context,
      'تم تسجيل مصروف ${created.category} بقيمة ${Fmt.money(created.amount)}',
      width: 480,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpensesController>(
      create: (_) => ExpensesController(),
      child: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: AppSpacing.page,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ScreenHeader(
                  title: 'المصروفات',
                  subtitle: 'تسجيل ومتابعة مصروفات التشغيل عبر الفروع',
                  actions: <Widget>[
                    PrimaryButton(
                      label: 'إضافة مصروف',
                      icon: Icons.add_rounded,
                      onPressed: () => _addExpense(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                const ExpensesStatCards(),
                const SizedBox(height: AppSpacing.xl),
                const ExpensesFilterBar(),
                const SizedBox(height: AppSpacing.lg),
                const Expanded(child: ExpensesTable()),
              ],
            ),
          );
        },
      ),
    );
  }
}
