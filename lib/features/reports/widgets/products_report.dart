import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/stat_card.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/reports_controller.dart';
import '../models/report_period.dart';
import 'products_report_table.dart';
import 'report_body.dart';

/// تقرير المنتجات: بطاقات + جدول أعلى 20 صنف.
class ProductsReport extends StatelessWidget {
  const ProductsReport({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController reports = context.watch<ReportsController>();
    final List<ProductSalesStat> stats = reports.topProducts;
    final double share = reports.branchShare;
    final String periodLabel = reports.period.label;

    final int totalUnits = stats.fold<int>(
      0,
      (int s, ProductSalesStat p) => s + (p.units * share).round(),
    );

    return ReportBody(
      summary: <Widget>[
        StatCard(
          title: 'أصناف تم بيعها',
          value: Fmt.count(stats.length),
          icon: Icons.inventory_2_outlined,
          iconColor: AppColors.accent,
          changePercent: 5.4,
          changeLabel: periodLabel,
        ),
        StatCard(
          title: 'إجمالي الوحدات',
          value: Fmt.count(totalUnits),
          icon: Icons.numbers_rounded,
          iconColor: AppColors.info,
          changePercent: 11.2,
          changeLabel: periodLabel,
        ),
        StatCard(
          title: 'الأكثر مبيعًا',
          value: stats.isEmpty ? '—' : stats.first.product.name,
          icon: Icons.emoji_events_outlined,
          iconColor: AppColors.warning,
          changeLabel: stats.isEmpty
              ? '—'
              : Fmt.moneyRounded(stats.first.revenue * share),
          changePercent: 21.8,
        ),
        StatCard(
          title: 'أصناف تحت الحد الأدنى',
          value: Fmt.count(MockData.lowStockProducts.length),
          icon: Icons.warning_amber_rounded,
          iconColor: AppColors.danger,
          higherIsBetter: false,
          changePercent: 7.5,
          changeLabel: 'تحتاج إعادة طلب',
        ),
      ],
      content: const ProductsReportTable(),
    );
  }
}
