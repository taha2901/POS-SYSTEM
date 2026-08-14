import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/stat_card.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/expenses_controller.dart';

/// البطاقات الإحصائية الأربعة فوق جدول المصروفات.
class ExpensesStatCards extends StatelessWidget {
  const ExpensesStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpensesController expenses = context.watch<ExpensesController>();

    return Row(
      children: <Widget>[
        Expanded(
          child: StatCard(
            title: 'صافي النقدية الحالي',
            value: Fmt.moneyRounded(MockData.netCash),
            icon: Icons.account_balance_wallet_outlined,
            iconColor: AppColors.success,
            changePercent: 8.9,
            changeLabel: 'مبيعات كاش − مصروفات معتمدة',
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'إجمالي مصروفات الشهر',
            value: Fmt.moneyRounded(MockData.monthExpenses),
            icon: Icons.receipt_long_outlined,
            iconColor: AppColors.danger,
            higherIsBetter: false,
            changePercent: 6.4,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'مصروفات بانتظار الاعتماد',
            value: Fmt.moneyRounded(expenses.pendingTotal),
            icon: Icons.pending_actions_outlined,
            iconColor: AppColors.warning,
            higherIsBetter: false,
            changeLabel: 'تحتاج مراجعة المدير',
            changePercent: 12.0,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'عدد المصروفات',
            value: Fmt.count(expenses.all.length),
            icon: Icons.list_alt_rounded,
            iconColor: AppColors.accent,
            changeLabel: 'خلال آخر 30 يوم',
            changePercent: 3.5,
          ),
        ),
      ],
    );
  }
}
