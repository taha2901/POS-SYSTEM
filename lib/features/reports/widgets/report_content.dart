import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/reports_controller.dart';
import '../models/report_type.dart';
import 'employees_report.dart';
import 'inventory_report.dart';
import 'products_report.dart';
import 'profit_report.dart';
import 'sales_report.dart';
import 'tax_report.dart';

/// محتوى التقرير المختار — بيتبدّل بأنيميشن Fade.
class ReportContent extends StatelessWidget {
  const ReportContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController reports = context.watch<ReportsController>();

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: reports.fadeController,
        curve: Curves.easeOut,
      ),
      child: switch (reports.type) {
        ReportType.sales => const SalesReport(),
        ReportType.profit => const ProfitReport(),
        ReportType.products => const ProductsReport(),
        ReportType.employees => const EmployeesReport(),
        ReportType.taxes => const TaxReport(),
        ReportType.inventory => const InventoryReport(),
      },
    );
  }
}
