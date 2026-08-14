import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/stat_card.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/branches_controller.dart';

/// البطاقات الإحصائية الأربعة فوق شبكة الفروع.
class BranchesStatCards extends StatelessWidget {
  const BranchesStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    final BranchesController branches = context.watch<BranchesController>();

    return Row(
      children: <Widget>[
        Expanded(
          child: StatCard(
            title: 'عدد الفروع',
            value: Fmt.count(branches.branchesCount),
            icon: Icons.store_outlined,
            iconColor: AppColors.accent,
            changeLabel: '${branches.openCount} مفتوح الآن',
            changePercent: 0,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'مبيعات اليوم — كل الفروع',
            value: Fmt.moneyRounded(branches.todayTotal),
            icon: Icons.trending_up_rounded,
            iconColor: AppColors.success,
            changePercent: 11.3,
            changeLabel: 'مقارنة بأمس',
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'إجمالي الموظفين',
            value: Fmt.count(MockData.employees.length),
            icon: Icons.badge_outlined,
            iconColor: AppColors.info,
            changePercent: 4.5,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'مبيعات الشهر',
            value: Fmt.moneyRounded(branches.monthTotal),
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.warning,
            changePercent: 16.8,
          ),
        ),
      ],
    );
  }
}
