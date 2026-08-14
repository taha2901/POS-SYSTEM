import 'package:flutter/material.dart';

/// أنواع التقارير المتاحة.
enum ReportType { sales, profit, products, employees, taxes, inventory }

extension ReportTypeInfo on ReportType {
  String get label => switch (this) {
        ReportType.sales => 'تقرير المبيعات',
        ReportType.profit => 'تقرير الأرباح',
        ReportType.products => 'تقرير المنتجات',
        ReportType.employees => 'أداء الموظفين',
        ReportType.taxes => 'التقرير الضريبي',
        ReportType.inventory => 'تقرير المخزون',
      };

  String get description => switch (this) {
        ReportType.sales => 'المبيعات اليومية والفواتير',
        ReportType.profit => 'الإيراد والتكلفة وهامش الربح',
        ReportType.products => 'الأصناف الأكثر مبيعًا وربحية',
        ReportType.employees => 'مبيعات كل موظف وأداؤه',
        ReportType.taxes => 'الضريبة المحصّلة والمستحقة',
        ReportType.inventory => 'قيمة المخزون حسب الفئة',
      };

  IconData get icon => switch (this) {
        ReportType.sales => Icons.show_chart_rounded,
        ReportType.profit => Icons.savings_outlined,
        ReportType.products => Icons.inventory_2_outlined,
        ReportType.employees => Icons.badge_outlined,
        ReportType.taxes => Icons.receipt_long_outlined,
        ReportType.inventory => Icons.warehouse_outlined,
      };
}
