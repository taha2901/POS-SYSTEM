import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_data_table.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/reports_controller.dart';
import '../models/report_period.dart';
import 'bar_cell.dart';
import 'report_icon_cell.dart';

/// جدول أداء المنتجات.
class ProductsReportTable extends StatelessWidget {
  const ProductsReportTable({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController reports = context.watch<ReportsController>();
    final List<ProductSalesStat> stats = reports.topProducts;
    final double share = reports.branchShare;
    final double maxRevenue = stats.isEmpty ? 1 : stats.first.revenue;

    return AppDataTable(
      title: 'أداء المنتجات',
      subtitle: 'أعلى 20 صنفًا خلال ${reports.period.label}',
      minWidth: 940,
      rowHeight: 58,
      columns: const <AppTableColumn>[
        AppTableColumn('المنتج', size: ColumnSize.L),
        AppTableColumn('الفئة', size: ColumnSize.M),
        AppTableColumn('الوحدات', size: ColumnSize.S, numeric: true),
        AppTableColumn('الإيراد', size: ColumnSize.M, numeric: true),
        AppTableColumn('الربح', size: ColumnSize.M, numeric: true),
        AppTableColumn('الحالة', size: ColumnSize.M),
      ],
      rows: <AppTableRow>[
        for (final ProductSalesStat s in stats)
          AppTableRow(
            cells: <Widget>[
              ReportIconCell(
                icon: s.product.categoryIcon,
                title: s.product.name,
                subtitle: s.product.sku,
                color: s.product.accentColor,
              ),
              TableCells.secondary(s.product.categoryName),
              TableCells.count((s.units * share).round()),
              BarCell(
                value: s.revenue * share,
                max: maxRevenue,
                color: s.product.accentColor,
              ),
              TableCells.amount(
                (s.product.price - s.product.cost) *
                    (s.units * share).round(),
                color: AppColors.success,
              ),
              StatusBadge.stock(
                stock: s.product.stock,
                minStock: s.product.minStock,
                compact: true,
              ),
            ],
          ),
      ],
    );
  }
}
