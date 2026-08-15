import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../models/category_report_row.dart';
import '../models/employee_report_row.dart';
import '../models/inventory_report_row.dart';
import '../models/monthly_tax_row.dart';
import '../models/report_period.dart';
import '../models/report_type.dart';

/// حالة شاشة التقارير: نوع التقرير والفترة والفرع المختارين.
class ReportsController extends ChangeNotifier {
  ReportsController({required TickerProvider vsync}) {
    fadeController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 320),
      value: 1,
    );
  }

  /// أنيميشن الـFade عند تبديل التقرير أو الفلاتر
  late final AnimationController fadeController;

  ReportType _type = ReportType.sales;
  ReportPeriod _period = ReportPeriod.month;
  String? _branchId;

  ReportType get type => _type;
  ReportPeriod get period => _period;
  String? get branchId => _branchId;

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void selectReport(ReportType type) {
    if (type == _type) return;
    _type = type;
    _replay();
  }

  void setPeriod(ReportPeriod period) {
    _period = period;
    _replay();
  }

  void setBranch(String? id) {
    _branchId = id;
    _replay();
  }

  /// إعادة بناء المحتوى مع إعادة تشغيل الـFade.
  void refresh() => _replay();

  void _replay() {
    fadeController
      ..reset()
      ..forward();
    notifyListeners();
  }

  // ── البيانات الأساسية ────────────────────────────────────────────────────
  List<SalesPoint> get series =>
      MockData.seriesFor(days: _period.days, branchId: _branchId);

  double get totalSales =>
      series.fold<double>(0, (double s, SalesPoint p) => s + p.sales);

  double get totalProfit =>
      series.fold<double>(0, (double s, SalesPoint p) => s + p.profit);

  int get totalInvoices =>
      series.fold<int>(0, (int s, SalesPoint p) => s + p.invoices);

  double get avgInvoice =>
      totalInvoices == 0 ? 0 : totalSales / totalInvoices;

  double get avgDay {
    final List<SalesPoint> s = series;
    return s.isEmpty ? 0 : totalSales / s.length;
  }

  /// حصة الفرع المختار (1 لو كل الفروع)
  double get branchShare =>
      _branchId == null ? 1 : (MockData.branchById(_branchId!)?.share ?? 1);

  /// في الفترات الطويلة بنجمّع أسبوعيًا عشان الأعمدة تفضل مقروءة.
  bool get isWeeklyChart => series.length > 45;

  List<SalesPoint> get chartPoints =>
      isWeeklyChart ? _groupWeekly(series) : series;

  List<SalesPoint> _groupWeekly(List<SalesPoint> series) {
    final List<SalesPoint> grouped = <SalesPoint>[];

    for (int i = 0; i < series.length; i += 7) {
      final List<SalesPoint> chunk =
          series.sublist(i, (i + 7).clamp(0, series.length));
      grouped.add(
        SalesPoint(
          date: chunk.first.date,
          sales: chunk.fold<double>(0, (double s, SalesPoint p) => s + p.sales),
          profit:
              chunk.fold<double>(0, (double s, SalesPoint p) => s + p.profit),
          invoices: chunk.fold<int>(0, (int s, SalesPoint p) => s + p.invoices),
          cash: chunk.fold<double>(0, (double s, SalesPoint p) => s + p.cash),
          card: chunk.fold<double>(0, (double s, SalesPoint p) => s + p.card),
          wallet:
              chunk.fold<double>(0, (double s, SalesPoint p) => s + p.wallet),
          credit:
              chunk.fold<double>(0, (double s, SalesPoint p) => s + p.credit),
        ),
      );
    }

    return grouped;
  }

  // ── تقرير الأرباح ────────────────────────────────────────────────────────
  /// تجميع المنتجات حسب الفئة.
  List<CategoryReportRow> get categoryRows {
    final Map<String, CategoryReportRow> map = <String, CategoryReportRow>{};
    final double share = branchShare;

    for (final ProductSalesStat stat
        in MockData.topProducts(count: 999, days: _period.days)) {
      final ProductCategory? category =
          MockData.categoryById(stat.product.categoryId);
      if (category == null) continue;

      final int units = (stat.units * share).round();
      final CategoryReportRow? existing = map[category.id];

      map[category.id] = CategoryReportRow(
        category: category,
        items: (existing?.items ?? 0) + 1,
        units: (existing?.units ?? 0) + units,
        revenue: (existing?.revenue ?? 0) + stat.product.price * units,
        cost: (existing?.cost ?? 0) + stat.product.cost * units,
      );
    }

    final List<CategoryReportRow> rows = map.values.toList();
    rows.sort(
      (CategoryReportRow a, CategoryReportRow b) =>
          b.revenue.compareTo(a.revenue),
    );
    return rows;
  }

  // ── تقرير المنتجات ───────────────────────────────────────────────────────
  List<ProductSalesStat> get topProducts =>
      MockData.topProducts(count: 20, days: _period.days);

  // ── تقرير الموظفين ───────────────────────────────────────────────────────
  List<Employee> get cashiers => MockData.employees
      .where((Employee e) => e.branchId == (_branchId ?? e.branchId))
      .toList();

  /// توزيع مبيعات الفترة على الموظفين حسب مبيعات اليوم.
  List<EmployeeReportRow> get employeeRows {
    final List<Employee> team = cashiers;
    final double dayTotal =
        team.fold<double>(0, (double s, Employee e) => s + e.todaySales);

    return <EmployeeReportRow>[
      for (final Employee e in team)
        EmployeeReportRow(
          employee: e,
          sales: dayTotal == 0 ? 0 : totalSales * (e.todaySales / dayTotal),
          invoices: dayTotal == 0
              ? 0
              : (totalInvoices * (e.todaySales / dayTotal)).round(),
        ),
    ]..sort(
        (EmployeeReportRow a, EmployeeReportRow b) =>
            b.sales.compareTo(a.sales),
      );
  }

  // ── التقرير الضريبي ──────────────────────────────────────────────────────
  double get taxCollected => totalSales * MockData.taxRate;

  /// ضريبة المشتريات المقدّرة من تكلفة البضاعة
  double get taxPaid => totalSales * 0.72 * MockData.taxRate;

  double get taxNet => taxCollected - taxPaid;

  List<MonthlyTaxRow> get monthlyTaxRows {
    final Map<String, MonthlyTaxRow> map = <String, MonthlyTaxRow>{};

    for (final SalesPoint p in series) {
      final String key = '${p.date.year}-${p.date.month}';
      final MonthlyTaxRow? existing = map[key];

      map[key] = MonthlyTaxRow(
        key: key,
        sales: (existing?.sales ?? 0) + p.sales,
        tax: (existing?.tax ?? 0) + p.sales * MockData.taxRate,
        invoices: (existing?.invoices ?? 0) + p.invoices,
      );
    }

    return map.values.toList().reversed.toList(growable: false);
  }

  // ── تقرير المخزون ────────────────────────────────────────────────────────
  List<InventoryReportRow> get inventoryRows {
    final Map<String, InventoryReportRow> map = <String, InventoryReportRow>{};

    for (final Product p in MockData.products) {
      final int stock =
          _branchId == null ? p.stock : MockData.onHandAt(p.id, _branchId!);
      final InventoryReportRow? existing = map[p.categoryId];

      map[p.categoryId] = InventoryReportRow(
        categoryId: p.categoryId,
        items: (existing?.items ?? 0) + 1,
        units: (existing?.units ?? 0) + stock,
        cost: (existing?.cost ?? 0) + p.cost * stock,
        retail: (existing?.retail ?? 0) + p.price * stock,
      );
    }

    return map.values.toList()
      ..sort(
        (InventoryReportRow a, InventoryReportRow b) =>
            b.cost.compareTo(a.cost),
      );
  }

  double get inventoryTotalCost =>
      inventoryRows.fold<double>(0, (double s, InventoryReportRow r) => s + r.cost);

  double get inventoryTotalRetail => inventoryRows
      .fold<double>(0, (double s, InventoryReportRow r) => s + r.retail);

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
  }
}
