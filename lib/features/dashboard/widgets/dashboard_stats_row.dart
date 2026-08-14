import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/staggered_reveal.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/dashboard_controller.dart';
import '../models/dashboard_period.dart';
import 'profit_margin_footer.dart';

/// صف البطاقات الإحصائية الأربعة.
class DashboardStatsRow extends StatelessWidget {
  const DashboardStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboard = context.watch<DashboardController>();
    final String comparison = dashboard.period.comparisonLabel;

    final List<Widget> cards = <Widget>[
      StatCard(
        title: 'إجمالي المبيعات',
        value: Fmt.moneyRounded(dashboard.sales),
        icon: Icons.trending_up_rounded,
        iconColor: AppColors.accent,
        changePercent: dashboard.salesChange,
        changeLabel: comparison,
      ),
      StatCard(
        title: 'صافي الربح',
        value: Fmt.moneyRounded(dashboard.profit),
        icon: Icons.savings_outlined,
        iconColor: AppColors.success,
        changePercent: dashboard.profitChange,
        changeLabel: comparison,
        footer: ProfitMarginFooter(margin: dashboard.profitMargin),
      ),
      StatCard(
        title: 'عدد الفواتير',
        value: Fmt.count(dashboard.invoices),
        icon: Icons.receipt_long_outlined,
        iconColor: AppColors.info,
        changePercent: dashboard.invoicesChange,
        changeLabel: comparison,
      ),
      StatCard(
        title: 'متوسط قيمة الفاتورة',
        value: Fmt.money(dashboard.avgInvoice),
        icon: Icons.shopping_basket_outlined,
        iconColor: AppColors.warning,
        changePercent: dashboard.avgInvoiceChange,
        changeLabel: comparison,
      ),
    ];

    // IntrinsicHeight عشان البطاقات تفضل بنفس الارتفاع جوه Scroll View
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < cards.length; i++) ...<Widget>[
            Expanded(
              child: StaggeredReveal(
                controller: dashboard.entryController,
                index: i + 1,
                child: cards[i],
              ),
            ),
            if (i != cards.length - 1) const SizedBox(width: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}
