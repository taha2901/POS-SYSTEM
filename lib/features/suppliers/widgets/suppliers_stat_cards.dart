import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/stat_card.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/suppliers_list_controller.dart';

/// البطاقات الإحصائية الأربعة فوق جدول الموردين.
class SuppliersStatCards extends StatelessWidget {
  const SuppliersStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    final SuppliersListController suppliers =
        context.watch<SuppliersListController>();

    return Row(
      children: <Widget>[
        Expanded(
          child: StatCard(
            title: 'إجمالي الموردين',
            value: Fmt.count(MockData.suppliers.length),
            icon: Icons.local_shipping_outlined,
            iconColor: AppColors.accent,
            changePercent: 5.0,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'المستحقات على الشركة',
            value: Fmt.moneyRounded(suppliers.totalDue),
            icon: Icons.account_balance_outlined,
            iconColor: AppColors.danger,
            higherIsBetter: false,
            changePercent: 7.6,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'موردون نشطون',
            value: Fmt.count(suppliers.activeCount),
            icon: Icons.verified_outlined,
            iconColor: AppColors.success,
            changePercent: 0,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'إجمالي المشتريات',
            value: Fmt.moneyRounded(suppliers.totalPurchases),
            icon: Icons.shopping_cart_outlined,
            iconColor: AppColors.info,
            changePercent: 19.2,
          ),
        ),
      ],
    );
  }
}
