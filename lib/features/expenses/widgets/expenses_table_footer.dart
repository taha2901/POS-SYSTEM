import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/expenses_controller.dart';

/// فوتر الجدول: إجمالي المصروفات المعروضة.
class ExpensesTableFooter extends StatelessWidget {
  const ExpensesTableFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpensesController expenses = context.watch<ExpensesController>();

    return Row(
      children: <Widget>[
        Text('إجمالي المصروفات المعروضة', style: AppText.caption),
        const Spacer(),
        Text(
          Fmt.money(expenses.visibleTotal),
          style: AppText.amountMd.copyWith(color: AppColors.danger),
        ),
      ],
    );
  }
}
