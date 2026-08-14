import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/stat_card.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/employees_list_controller.dart';

/// البطاقات الإحصائية الأربعة فوق جدول الموظفين.
class EmployeesStatCards extends StatelessWidget {
  const EmployeesStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeesListController employees =
        context.watch<EmployeesListController>();

    return Row(
      children: <Widget>[
        Expanded(
          child: StatCard(
            title: 'إجمالي الموظفين',
            value: Fmt.count(MockData.employees.length),
            icon: Icons.badge_outlined,
            iconColor: AppColors.accent,
            changePercent: 0,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'موظفون نشطون',
            value: Fmt.count(employees.activeCount),
            icon: Icons.how_to_reg_outlined,
            iconColor: AppColors.success,
            changePercent: 4.5,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'مبيعات اليوم للفريق',
            value: Fmt.moneyRounded(employees.todaySales),
            icon: Icons.trending_up_rounded,
            iconColor: AppColors.info,
            changeLabel: 'مقارنة بأمس',
            changePercent: 11.8,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'إجمالي الرواتب الشهرية',
            value: Fmt.moneyRounded(employees.totalSalaries),
            icon: Icons.payments_outlined,
            iconColor: AppColors.warning,
            higherIsBetter: false,
            changePercent: 2.1,
          ),
        ),
      ],
    );
  }
}
