import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../mock_data/mock_data.dart';
import '../controllers/expenses_controller.dart';

/// فلتر فئة المصروف.
class ExpensesCategoryDropdown extends StatelessWidget {
  const ExpensesCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpensesController expenses = context.watch<ExpensesController>();

    return AppDropdown<String?>(
      value: expenses.category,
      width: 190,
      icon: Icons.category_outlined,
      onChanged: expenses.setCategory,
      items: <AppDropdownItem<String?>>[
        const AppDropdownItem<String?>(
          value: null,
          label: 'كل الفئات',
          icon: Icons.apps_rounded,
        ),
        for (final String c in MockData.expenseCategories)
          AppDropdownItem<String?>(value: c, label: c),
      ],
    );
  }
}
