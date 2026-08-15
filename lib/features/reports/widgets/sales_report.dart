import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/stat_card.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/reports_controller.dart';
import '../models/report_period.dart';
import 'report_body.dart';
import 'sales_bar_chart.dart';
import 'sales_report_table.dart';

/// تقرير المبيعات: بطاقات + رسم أعمدة + جدول يومي.
class SalesReport extends StatelessWidget {
  const SalesReport({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController reports = context.watch<ReportsController>();
    final String periodLabel = reports.period.label;

    return ReportBody(
      summary: <Widget>[
        StatCard(
          title: 'إجمالي المبيعات',
          value: Fmt.moneyRounded(reports.totalSales),
          icon: Icons.trending_up_rounded,
          iconColor: AppColors.accent,
          changePercent: 12.4,
          changeLabel: periodLabel,
        ),
        StatCard(
          title: 'عدد الفواتير',
          value: Fmt.count(reports.totalInvoices),
          icon: Icons.receipt_long_outlined,
          iconColor: AppColors.info,
          changePercent: 8.1,
          changeLabel: periodLabel,
        ),
        StatCard(
          title: 'متوسط الفاتورة',
          value: Fmt.money(reports.avgInvoice),
          icon: Icons.shopping_basket_outlined,
          iconColor: AppColors.warning,
          changePercent: 3.9,
          changeLabel: periodLabel,
        ),
        StatCard(
          title: 'متوسط اليوم',
          value: Fmt.moneyRounded(reports.avgDay),
          icon: Icons.calendar_today_outlined,
          iconColor: AppColors.success,
          changePercent: 6.7,
          changeLabel: periodLabel,
        ),
      ],
      contentHeight: 780,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 300,
            child: SalesBarChart(
              points: reports.chartPoints,
              weekly: reports.isWeeklyChart,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Expanded(child: SalesReportTable()),
        ],
      ),
    );
  }
}
