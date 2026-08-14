import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/staggered_reveal.dart';
import '../../../theme/app_theme.dart';
import '../controllers/dashboard_controller.dart';
import '../models/dashboard_period.dart';
import 'payment_pie_chart.dart';
import 'sales_trend_chart.dart';

/// صف الرسوم البيانية: اتجاه المبيعات + طرق الدفع.
class DashboardChartsRow extends StatelessWidget {
  const DashboardChartsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboard = context.watch<DashboardController>();

    return SizedBox(
      height: 400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: StaggeredReveal(
              controller: dashboard.entryController,
              index: 5,
              child: SalesTrendChart(
                points: dashboard.current,
                periodLabel: dashboard.period.label,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            flex: 2,
            child: StaggeredReveal(
              controller: dashboard.entryController,
              index: 6,
              child: PaymentPieChart(slices: dashboard.paymentSlices),
            ),
          ),
        ],
      ),
    );
  }
}
