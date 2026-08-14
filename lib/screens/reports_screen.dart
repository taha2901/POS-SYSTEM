import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../mock_data/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../core/widgets/app_data_table.dart';
import '../core/widgets/app_dropdown.dart';
import '../core/widgets/primary_button.dart';
import '../core/widgets/screen_header.dart';
import '../core/widgets/secondary_button.dart';
import '../core/widgets/stat_card.dart';
import '../core/widgets/status_badge.dart';

/// أنواع التقارير المتاحة
enum ReportType { sales, profit, products, employees, taxes, inventory }

extension on ReportType {
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

enum ReportPeriod { week, month, quarter, year }

extension on ReportPeriod {
  String get label => switch (this) {
        ReportPeriod.week => 'آخر 7 أيام',
        ReportPeriod.month => 'آخر 30 يوم',
        ReportPeriod.quarter => 'آخر 90 يوم',
        ReportPeriod.year => 'آخر سنة',
      };

  int get days => switch (this) {
        ReportPeriod.week => 7,
        ReportPeriod.month => 30,
        ReportPeriod.quarter => 90,
        ReportPeriod.year => 365,
      };
}

/// سطر مجمّع حسب الفئة (يُستخدم في تقارير الأرباح والمخزون)
class _CategoryRow {
  const _CategoryRow({
    required this.category,
    required this.items,
    required this.units,
    required this.revenue,
    required this.cost,
  });

  final ProductCategory category;
  final int items;
  final int units;
  final double revenue;
  final double cost;

  double get profit => revenue - cost;
  double get margin => revenue == 0 ? 0 : (profit / revenue) * 100;
}

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  ReportType _type = ReportType.sales;
  ReportPeriod _period = ReportPeriod.month;
  String? _branchId;

  late final AnimationController _fade = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 320),
    value: 1,
  );

  @override
  void dispose() {
    _fade.dispose();
    super.dispose();
  }

  void _selectReport(ReportType type) {
    if (type == _type) return;
    setState(() => _type = type);
    _fade
      ..reset()
      ..forward();
  }

  void _refresh() {
    setState(() {});
    _fade
      ..reset()
      ..forward();
  }

  // ── البيانات ───────────────────────────────────────────────────────────
  List<SalesPoint> get _series =>
      MockData.seriesFor(days: _period.days, branchId: _branchId);

  double get _totalSales =>
      _series.fold<double>(0, (double s, SalesPoint p) => s + p.sales);
  double get _totalProfit =>
      _series.fold<double>(0, (double s, SalesPoint p) => s + p.profit);
  int get _totalInvoices =>
      _series.fold<int>(0, (int s, SalesPoint p) => s + p.invoices);

  /// حصة الفرع المختار (1 لو كل الفروع)
  double get _branchShare =>
      _branchId == null ? 1 : (MockData.branchById(_branchId!)?.share ?? 1);

  /// تجميع المنتجات حسب الفئة
  List<_CategoryRow> get _categoryRows {
    final Map<String, _CategoryRow> map = <String, _CategoryRow>{};

    for (final ProductSalesStat stat
        in MockData.topProducts(count: 999, days: _period.days)) {
      final ProductCategory? category =
          MockData.categoryById(stat.product.categoryId);
      if (category == null) continue;

      final int units = (stat.units * _branchShare).round();
      final _CategoryRow? existing = map[category.id];

      map[category.id] = _CategoryRow(
        category: category,
        items: (existing?.items ?? 0) + 1,
        units: (existing?.units ?? 0) + units,
        revenue: (existing?.revenue ?? 0) + stat.product.price * units,
        cost: (existing?.cost ?? 0) + stat.product.cost * units,
      );
    }

    final List<_CategoryRow> rows = map.values.toList();
    rows.sort((_CategoryRow a, _CategoryRow b) =>
        b.revenue.compareTo(a.revenue));
    return rows;
  }

  void _export(String format) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'جارٍ تصدير «${_type.label}» بصيغة $format عن ${_period.label} (تجريبي)',
          ),
          width: 520,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.page,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ScreenHeader(
            title: 'التقارير',
            subtitle: 'تحليلات تفصيلية قابلة للتصدير عن أداء المتجر',
            actions: <Widget>[
              SecondaryButton(
                label: 'تحديث',
                icon: Icons.refresh_rounded,
                onPressed: _refresh,
              ),
              SecondaryButton(
                label: 'تصدير Excel',
                icon: Icons.table_view_outlined,
                tone: SecondaryButtonTone.success,
                onPressed: () => _export('Excel'),
              ),
              PrimaryButton(
                label: 'تصدير PDF',
                icon: Icons.picture_as_pdf_outlined,
                onPressed: () => _export('PDF'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _buildToolbar(),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // قائمة التقارير (يمين في RTL)
                SizedBox(width: 264, child: _buildReportsList()),
                const SizedBox(width: AppSpacing.xl),
                Expanded(
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _fade,
                      curve: Curves.easeOut,
                    ),
                    child: _buildReportContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── شريط الفلاتر ───────────────────────────────────────────────────────
  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: AppDecorations.card(radius: AppRadius.md),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.filter_alt_outlined,
            size: 17,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text('الفترة', style: AppText.label.copyWith(fontSize: 12.5)),
          const SizedBox(width: AppSpacing.md),
          for (final ReportPeriod p in ReportPeriod.values) ...<Widget>[
            _PeriodChip(
              label: p.label,
              selected: _period == p,
              onTap: () {
                setState(() => _period = p);
                _fade
                  ..reset()
                  ..forward();
              },
            ),
            const SizedBox(width: 4),
          ],
          const Spacer(),
          AppDropdown<String?>(
            value: _branchId,
            width: 220,
            height: 40,
            icon: Icons.store_outlined,
            onChanged: (String? v) {
              setState(() => _branchId = v);
              _fade
                ..reset()
                ..forward();
            },
            items: <AppDropdownItem<String?>>[
              const AppDropdownItem<String?>(
                value: null,
                label: 'كل الفروع',
                icon: Icons.apps_rounded,
              ),
              for (final Branch b in MockData.branches)
                AppDropdownItem<String?>(
                  value: b.id,
                  label: b.name,
                  icon: b.isMain ? Icons.star_rounded : Icons.store_outlined,
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ── قائمة التقارير ─────────────────────────────────────────────────────
  Widget _buildReportsList() {
    return Container(
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: <Widget>[
          for (final ReportType t in ReportType.values)
            _ReportTile(
              type: t,
              selected: _type == t,
              onTap: () => _selectReport(t),
            ),
        ],
      ),
    );
  }

  // ── محتوى التقرير ──────────────────────────────────────────────────────
  Widget _buildReportContent() {
    return switch (_type) {
      ReportType.sales => _buildSalesReport(),
      ReportType.profit => _buildProfitReport(),
      ReportType.products => _buildProductsReport(),
      ReportType.employees => _buildEmployeesReport(),
      ReportType.taxes => _buildTaxReport(),
      ReportType.inventory => _buildInventoryReport(),
    };
  }

  /// الغلاف الموحّد لأي تقرير: بطاقات ملخّص + محتوى بارتفاع ثابت.
  ///
  /// بنستخدم ارتفاع صريح مع Scroll View بدل Expanded عشان المحتوى
  /// ما ينضغطش لما البطاقات تتغيّر أو الشاشة تصغّر.
  Widget _reportBody({
    required List<Widget> summary,
    required Widget content,
    double contentHeight = 520,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (int i = 0; i < summary.length; i++) ...<Widget>[
                  Expanded(child: summary[i]),
                  if (i != summary.length - 1)
                    const SizedBox(width: AppSpacing.lg),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(height: contentHeight, child: content),
        ],
      ),
    );
  }

  // ── 1. تقرير المبيعات ──────────────────────────────────────────────────
  Widget _buildSalesReport() {
    final List<SalesPoint> series = _series;
    // في الفترات الطويلة بنجمّع أسبوعيًا عشان الأعمدة تفضل مقروءة
    final bool weekly = series.length > 45;
    final List<SalesPoint> chartData = weekly ? _groupWeekly(series) : series;

    return _reportBody(
      summary: <Widget>[
        StatCard(
          title: 'إجمالي المبيعات',
          value: Fmt.moneyRounded(_totalSales),
          icon: Icons.trending_up_rounded,
          iconColor: AppColors.accent,
          changePercent: 12.4,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'عدد الفواتير',
          value: Fmt.count(_totalInvoices),
          icon: Icons.receipt_long_outlined,
          iconColor: AppColors.info,
          changePercent: 8.1,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'متوسط الفاتورة',
          value: Fmt.money(
            _totalInvoices == 0 ? 0 : _totalSales / _totalInvoices,
          ),
          icon: Icons.shopping_basket_outlined,
          iconColor: AppColors.warning,
          changePercent: 3.9,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'متوسط اليوم',
          value: Fmt.moneyRounded(
            series.isEmpty ? 0 : _totalSales / series.length,
          ),
          icon: Icons.calendar_today_outlined,
          iconColor: AppColors.success,
          changePercent: 6.7,
          changeLabel: _period.label,
        ),
      ],
      contentHeight: 780,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 300,
            child: _SalesBarChart(
              points: chartData,
              weekly: weekly,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: AppDataTable(
              title: 'التفاصيل اليومية',
              subtitle: '${Fmt.count(series.length)} يوم',
              minWidth: 760,
              rowHeight: 54,
              columns: const <AppTableColumn>[
                AppTableColumn('التاريخ', size: ColumnSize.M),
                AppTableColumn('الفواتير', size: ColumnSize.S, numeric: true),
                AppTableColumn(
                  'المبيعات',
                  size: ColumnSize.M,
                  numeric: true,
                ),
                AppTableColumn('الضريبة', size: ColumnSize.S, numeric: true),
                AppTableColumn('صافي الربح', size: ColumnSize.M, numeric: true),
              ],
              rows: <AppTableRow>[
                for (final SalesPoint p in series.reversed)
                  AppTableRow(
                    cells: <Widget>[
                      TableCells.twoLine(
                        Fmt.date(p.date),
                        _weekdayName(p.date),
                      ),
                      TableCells.count(p.invoices),
                      TableCells.amount(p.sales),
                      TableCells.amount(
                        p.sales * MockData.taxRate,
                        color: AppColors.textSecondary,
                      ),
                      TableCells.amount(p.profit, color: AppColors.success),
                    ],
                  ),
              ],
              footer: _footerTotals(<(String, String)>[
                ('إجمالي الفواتير', Fmt.count(_totalInvoices)),
                ('إجمالي المبيعات', Fmt.money(_totalSales)),
                ('إجمالي الأرباح', Fmt.money(_totalProfit)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

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

  String _weekdayName(DateTime d) => switch (d.weekday) {
        DateTime.saturday => 'السبت',
        DateTime.sunday => 'الأحد',
        DateTime.monday => 'الاثنين',
        DateTime.tuesday => 'الثلاثاء',
        DateTime.wednesday => 'الأربعاء',
        DateTime.thursday => 'الخميس',
        _ => 'الجمعة',
      };

  // ── 2. تقرير الأرباح ───────────────────────────────────────────────────
  Widget _buildProfitReport() {
    final List<_CategoryRow> rows = _categoryRows;
    final double revenue =
        rows.fold<double>(0, (double s, _CategoryRow r) => s + r.revenue);
    final double cost =
        rows.fold<double>(0, (double s, _CategoryRow r) => s + r.cost);
    final double profit = revenue - cost;
    final double maxRevenue = rows.isEmpty ? 1 : rows.first.revenue;

    return _reportBody(
      summary: <Widget>[
        StatCard(
          title: 'إجمالي الإيراد',
          value: Fmt.moneyRounded(revenue),
          icon: Icons.attach_money_rounded,
          iconColor: AppColors.accent,
          changePercent: 14.2,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'تكلفة البضاعة المباعة',
          value: Fmt.moneyRounded(cost),
          icon: Icons.shopping_bag_outlined,
          iconColor: AppColors.warning,
          higherIsBetter: false,
          changePercent: 9.8,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'صافي الربح',
          value: Fmt.moneyRounded(profit),
          icon: Icons.savings_outlined,
          iconColor: AppColors.success,
          changePercent: 18.6,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'هامش الربح',
          value: Fmt.percent(revenue == 0 ? 0 : (profit / revenue) * 100),
          icon: Icons.percent_rounded,
          iconColor: AppColors.info,
          changePercent: 2.3,
          changeLabel: _period.label,
        ),
      ],
      content: AppDataTable(
        title: 'الربحية حسب الفئة',
        subtitle: 'مرتّبة تنازليًا حسب الإيراد',
        minWidth: 900,
        rowHeight: 58,
        columns: const <AppTableColumn>[
          AppTableColumn('الفئة', size: ColumnSize.L),
          AppTableColumn('الوحدات', size: ColumnSize.S, numeric: true),
          AppTableColumn('الإيراد', size: ColumnSize.M, numeric: true),
          AppTableColumn('التكلفة', size: ColumnSize.M, numeric: true),
          AppTableColumn('الربح', size: ColumnSize.M, numeric: true),
          AppTableColumn('الهامش', size: ColumnSize.M),
        ],
        rows: <AppTableRow>[
          for (final _CategoryRow r in rows)
            AppTableRow(
              cells: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.10),
                        borderRadius: AppRadius.smAll,
                      ),
                      child: Icon(
                        r.category.icon,
                        size: 16,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: TableCells.twoLine(
                        r.category.name,
                        '${Fmt.count(r.items)} صنف',
                      ),
                    ),
                  ],
                ),
                TableCells.count(r.units),
                _BarCell(value: r.revenue, max: maxRevenue),
                TableCells.amount(r.cost, color: AppColors.textSecondary),
                TableCells.amount(r.profit, color: AppColors.success),
                _MarginCell(margin: r.margin),
              ],
            ),
        ],
        footer: _footerTotals(<(String, String)>[
          ('الإيراد', Fmt.money(revenue)),
          ('التكلفة', Fmt.money(cost)),
          ('الربح', Fmt.money(profit)),
        ]),
      ),
    );
  }

  // ── 3. تقرير المنتجات ──────────────────────────────────────────────────
  Widget _buildProductsReport() {
    final List<ProductSalesStat> stats =
        MockData.topProducts(count: 20, days: _period.days);
    final double maxRevenue = stats.isEmpty ? 1 : stats.first.revenue;

    final int totalUnits = stats.fold<int>(
      0,
      (int s, ProductSalesStat p) => s + (p.units * _branchShare).round(),
    );

    return _reportBody(
      summary: <Widget>[
        StatCard(
          title: 'أصناف تم بيعها',
          value: Fmt.count(stats.length),
          icon: Icons.inventory_2_outlined,
          iconColor: AppColors.accent,
          changePercent: 5.4,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'إجمالي الوحدات',
          value: Fmt.count(totalUnits),
          icon: Icons.numbers_rounded,
          iconColor: AppColors.info,
          changePercent: 11.2,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'الأكثر مبيعًا',
          value: stats.isEmpty ? '—' : stats.first.product.name,
          icon: Icons.emoji_events_outlined,
          iconColor: AppColors.warning,
          changeLabel: stats.isEmpty
              ? '—'
              : Fmt.moneyRounded(stats.first.revenue * _branchShare),
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
      content: AppDataTable(
        title: 'أداء المنتجات',
        subtitle: 'أعلى 20 صنفًا خلال ${_period.label}',
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
                Row(
                  children: <Widget>[
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color:
                            s.product.accentColor.withValues(alpha: 0.12),
                        borderRadius: AppRadius.smAll,
                      ),
                      child: Icon(
                        s.product.categoryIcon,
                        size: 16,
                        color: s.product.accentColor,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: TableCells.twoLine(s.product.name, s.product.sku),
                    ),
                  ],
                ),
                TableCells.secondary(s.product.categoryName),
                TableCells.count((s.units * _branchShare).round()),
                _BarCell(
                  value: s.revenue * _branchShare,
                  max: maxRevenue,
                  color: s.product.accentColor,
                ),
                TableCells.amount(
                  (s.product.price - s.product.cost) *
                      (s.units * _branchShare).round(),
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
      ),
    );
  }

  // ── 4. أداء الموظفين ───────────────────────────────────────────────────
  Widget _buildEmployeesReport() {
    final List<Employee> cashiers = MockData.employees
        .where((Employee e) => e.branchId == (_branchId ?? e.branchId))
        .toList();

    // توزيع مبيعات الفترة على الموظفين النشطين حسب مبيعات اليوم
    final double dayTotal = cashiers.fold<double>(
      0,
      (double s, Employee e) => s + e.todaySales,
    );

    final List<({Employee employee, double sales, int invoices})> rows =
        <({Employee employee, double sales, int invoices})>[
      for (final Employee e in cashiers)
        (
          employee: e,
          sales: dayTotal == 0
              ? 0
              : _totalSales * (e.todaySales / dayTotal),
          invoices: dayTotal == 0
              ? 0
              : (_totalInvoices * (e.todaySales / dayTotal)).round(),
        ),
    ]..sort(
        (({Employee employee, double sales, int invoices}) a,
                ({Employee employee, double sales, int invoices}) b) =>
            b.sales.compareTo(a.sales),
      );

    final double maxSales = rows.isEmpty || rows.first.sales == 0
        ? 1
        : rows.first.sales;

    return _reportBody(
      summary: <Widget>[
        StatCard(
          title: 'عدد الموظفين',
          value: Fmt.count(cashiers.length),
          icon: Icons.badge_outlined,
          iconColor: AppColors.accent,
          changePercent: 0,
          changeLabel: _branchId == null ? 'كل الفروع' : 'الفرع المختار',
        ),
        StatCard(
          title: 'مبيعات الفريق',
          value: Fmt.moneyRounded(_totalSales),
          icon: Icons.trending_up_rounded,
          iconColor: AppColors.success,
          changePercent: 12.4,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'أعلى موظف مبيعًا',
          value: rows.isEmpty ? '—' : rows.first.employee.name,
          icon: Icons.emoji_events_outlined,
          iconColor: AppColors.warning,
          changeLabel:
              rows.isEmpty ? '—' : Fmt.moneyRounded(rows.first.sales),
          changePercent: 16.3,
        ),
        StatCard(
          title: 'متوسط الفاتورة للفريق',
          value: Fmt.money(
            _totalInvoices == 0 ? 0 : _totalSales / _totalInvoices,
          ),
          icon: Icons.shopping_basket_outlined,
          iconColor: AppColors.info,
          changePercent: 4.1,
          changeLabel: _period.label,
        ),
      ],
      content: AppDataTable(
        title: 'أداء الموظفين',
        subtitle: 'المبيعات موزّعة على الفريق خلال ${_period.label}',
        minWidth: 900,
        rowHeight: 62,
        columns: const <AppTableColumn>[
          AppTableColumn('الموظف', size: ColumnSize.L),
          AppTableColumn('الدور', size: ColumnSize.M),
          AppTableColumn('الفرع', size: ColumnSize.M),
          AppTableColumn('الفواتير', size: ColumnSize.S, numeric: true),
          AppTableColumn('المبيعات', size: ColumnSize.M, numeric: true),
          AppTableColumn('الحالة', size: ColumnSize.S),
        ],
        rows: <AppTableRow>[
          for (final ({Employee employee, double sales, int invoices}) r
              in rows)
            AppTableRow(
              cells: <Widget>[
                TableCells.avatarName(
                  r.employee.name,
                  r.employee.initials,
                  color: r.employee.isActive
                      ? AppColors.accent
                      : AppColors.textMuted,
                  subtitle: r.employee.phone,
                ),
                TableCells.secondary(r.employee.role),
                TableCells.secondary(r.employee.branchName),
                TableCells.count(r.invoices),
                _BarCell(value: r.sales, max: maxSales),
                StatusBadge(
                  label: r.employee.isActive ? 'نشط' : 'موقوف',
                  tone: r.employee.isActive
                      ? StatusTone.success
                      : StatusTone.neutral,
                  compact: true,
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ── 5. التقرير الضريبي ─────────────────────────────────────────────────
  Widget _buildTaxReport() {
    final List<SalesPoint> series = _series;
    final double collected = _totalSales * MockData.taxRate;

    // ضريبة المشتريات المقدّرة من تكلفة البضاعة
    final double purchases = _totalSales * 0.72;
    final double paid = purchases * MockData.taxRate;
    final double net = collected - paid;

    // تجميع شهري
    final Map<String, ({double sales, double tax, int invoices})> monthly =
        <String, ({double sales, double tax, int invoices})>{};
    for (final SalesPoint p in series) {
      final String key = '${p.date.year}-${p.date.month}';
      final ({double sales, double tax, int invoices})? existing =
          monthly[key];
      monthly[key] = (
        sales: (existing?.sales ?? 0) + p.sales,
        tax: (existing?.tax ?? 0) + p.sales * MockData.taxRate,
        invoices: (existing?.invoices ?? 0) + p.invoices,
      );
    }

    return _reportBody(
      summary: <Widget>[
        StatCard(
          title: 'المبيعات الخاضعة للضريبة',
          value: Fmt.moneyRounded(_totalSales),
          icon: Icons.point_of_sale_rounded,
          iconColor: AppColors.accent,
          changePercent: 12.4,
          changeLabel: _period.label,
        ),
        StatCard(
          title: 'ضريبة محصّلة',
          value: Fmt.moneyRounded(collected),
          icon: Icons.arrow_downward_rounded,
          iconColor: AppColors.success,
          changePercent: 12.4,
          changeLabel: '${(MockData.taxRate * 100).toStringAsFixed(0)}% من المبيعات',
        ),
        StatCard(
          title: 'ضريبة مشتريات',
          value: Fmt.moneyRounded(paid),
          icon: Icons.arrow_upward_rounded,
          iconColor: AppColors.warning,
          changePercent: 9.1,
          changeLabel: 'قابلة للخصم',
        ),
        StatCard(
          title: 'صافي المستحق للمصلحة',
          value: Fmt.moneyRounded(net),
          icon: Icons.account_balance_outlined,
          iconColor: AppColors.danger,
          higherIsBetter: false,
          changePercent: 14.8,
          changeLabel: 'محصّلة − مشتريات',
        ),
      ],
      content: AppDataTable(
        title: 'الإقرار الضريبي الشهري',
        subtitle: 'ملخص شهري عن ${_period.label}',
        minWidth: 820,
        rowHeight: 58,
        columns: const <AppTableColumn>[
          AppTableColumn('الشهر', size: ColumnSize.M),
          AppTableColumn('الفواتير', size: ColumnSize.S, numeric: true),
          AppTableColumn('المبيعات', size: ColumnSize.M, numeric: true),
          AppTableColumn('الضريبة المحصّلة', size: ColumnSize.M, numeric: true),
          AppTableColumn('الحالة', size: ColumnSize.M),
        ],
        rows: <AppTableRow>[
          for (final MapEntry<String,
                  ({double sales, double tax, int invoices})> e
              in monthly.entries.toList().reversed)
            AppTableRow(
              cells: <Widget>[
                Text(
                  _monthLabel(e.key),
                  style: AppText.bodyMedium.copyWith(fontSize: 13.5),
                ),
                TableCells.count(e.value.invoices),
                TableCells.amount(e.value.sales),
                TableCells.amount(e.value.tax, color: AppColors.success),
                StatusBadge(
                  label: _isCurrentMonth(e.key) ? 'جارٍ' : 'تم التقديم',
                  tone: _isCurrentMonth(e.key)
                      ? StatusTone.warning
                      : StatusTone.success,
                  compact: true,
                ),
              ],
            ),
        ],
        footer: _footerTotals(<(String, String)>[
          ('محصّلة', Fmt.money(collected)),
          ('مشتريات', Fmt.money(paid)),
          ('الصافي', Fmt.money(net)),
        ]),
      ),
    );
  }

  bool _isCurrentMonth(String key) =>
      key == '${MockData.today.year}-${MockData.today.month}';

  String _monthLabel(String key) {
    const List<String> names = <String>[
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    final List<String> parts = key.split('-');
    final int month = int.tryParse(parts[1]) ?? 1;
    return '${names[(month - 1).clamp(0, 11)]} ${parts[0]}';
  }

  // ── 6. تقرير المخزون ───────────────────────────────────────────────────
  Widget _buildInventoryReport() {
    final Map<String, ({int items, int units, double cost, double retail})>
        byCategory =
        <String, ({int items, int units, double cost, double retail})>{};

    for (final Product p in MockData.products) {
      final int stock = _branchId == null
          ? p.stock
          : MockData.onHandAt(p.id, _branchId!);
      final ({int items, int units, double cost, double retail})? existing =
          byCategory[p.categoryId];

      byCategory[p.categoryId] = (
        items: (existing?.items ?? 0) + 1,
        units: (existing?.units ?? 0) + stock,
        cost: (existing?.cost ?? 0) + p.cost * stock,
        retail: (existing?.retail ?? 0) + p.price * stock,
      );
    }

    final double totalCost = byCategory.values
        .fold<double>(0, (double s, dynamic v) => s + (v.cost as double));
    final double totalRetail = byCategory.values
        .fold<double>(0, (double s, dynamic v) => s + (v.retail as double));
    final double maxCost = byCategory.values.isEmpty
        ? 1
        : byCategory.values
            .map((({int items, int units, double cost, double retail}) v) =>
                v.cost)
            .reduce((double a, double b) => a > b ? a : b);

    return _reportBody(
      summary: <Widget>[
        StatCard(
          title: 'قيمة المخزون بالتكلفة',
          value: Fmt.moneyRounded(totalCost),
          icon: Icons.warehouse_outlined,
          iconColor: AppColors.accent,
          changePercent: 6.4,
          changeLabel: _branchId == null ? 'كل الفروع' : 'الفرع المختار',
        ),
        StatCard(
          title: 'قيمة المخزون بالبيع',
          value: Fmt.moneyRounded(totalRetail),
          icon: Icons.sell_outlined,
          iconColor: AppColors.info,
          changePercent: 7.2,
          changeLabel: 'لو اتباع كامل',
        ),
        StatCard(
          title: 'الربح المتوقع',
          value: Fmt.moneyRounded(totalRetail - totalCost),
          icon: Icons.savings_outlined,
          iconColor: AppColors.success,
          changePercent: 9.5,
          changeLabel: 'الفرق بين البيع والتكلفة',
        ),
        StatCard(
          title: 'أصناف نافدة',
          value: Fmt.count(MockData.outOfStockProducts.length),
          icon: Icons.remove_shopping_cart_outlined,
          iconColor: AppColors.danger,
          higherIsBetter: false,
          changePercent: -25.0,
          changeLabel: 'مقارنة بالأسبوع الماضي',
        ),
      ],
      content: AppDataTable(
        title: 'قيمة المخزون حسب الفئة',
        subtitle: 'مرتّبة حسب قيمة التكلفة',
        minWidth: 900,
        rowHeight: 58,
        columns: const <AppTableColumn>[
          AppTableColumn('الفئة', size: ColumnSize.L),
          AppTableColumn('الأصناف', size: ColumnSize.S, numeric: true),
          AppTableColumn('الوحدات', size: ColumnSize.S, numeric: true),
          AppTableColumn('قيمة التكلفة', size: ColumnSize.M, numeric: true),
          AppTableColumn('قيمة البيع', size: ColumnSize.M, numeric: true),
          AppTableColumn('الربح المتوقع', size: ColumnSize.M, numeric: true),
        ],
        rows: <AppTableRow>[
          for (final MapEntry<String,
                  ({int items, int units, double cost, double retail})> e
              in (byCategory.entries.toList()
                ..sort((MapEntry<String, dynamic> a,
                        MapEntry<String, dynamic> b) =>
                    (b.value.cost as double)
                        .compareTo(a.value.cost as double))))
            AppTableRow(
              cells: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.10),
                        borderRadius: AppRadius.smAll,
                      ),
                      child: Icon(
                        MockData.categoryById(e.key)?.icon ??
                            Icons.category_outlined,
                        size: 16,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: TableCells.primary(
                        MockData.categoryById(e.key)?.name ?? '—',
                      ),
                    ),
                  ],
                ),
                TableCells.count(e.value.items),
                TableCells.count(e.value.units),
                _BarCell(value: e.value.cost, max: maxCost),
                TableCells.amount(
                  e.value.retail,
                  color: AppColors.textSecondary,
                ),
                TableCells.amount(
                  e.value.retail - e.value.cost,
                  color: AppColors.success,
                ),
              ],
            ),
        ],
        footer: _footerTotals(<(String, String)>[
          ('التكلفة', Fmt.money(totalCost)),
          ('البيع', Fmt.money(totalRetail)),
          ('الربح', Fmt.money(totalRetail - totalCost)),
        ]),
      ),
    );
  }

  Widget _footerTotals(List<(String, String)> totals) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < totals.length; i++) ...<Widget>[
          if (i > 0)
            Container(
              width: 1,
              height: 22,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              color: AppColors.border,
            ),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  totals[i].$1,
                  style: AppText.caption.copyWith(fontSize: 12),
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    totals[i].$2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.amountSm.copyWith(fontSize: 13.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// عناصر داخلية
// ═══════════════════════════════════════════════════════════════════════════

class _ReportTile extends StatefulWidget {
  const _ReportTile({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final ReportType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<_ReportTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool active = widget.selected;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: active
                ? AppColors.accentSoft
                : _hovered
                    ? AppColors.surfaceAlt
                    : Colors.transparent,
            borderRadius: AppRadius.mdAll,
            border: Border.all(
              color: active ? AppColors.accent : Colors.transparent,
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.accent
                      : AppColors.accent.withValues(alpha: 0.10),
                  borderRadius: AppRadius.smAll,
                ),
                child: Icon(
                  widget.type.icon,
                  size: 17,
                  color: active ? Colors.white : AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.type.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyMedium.copyWith(
                        fontSize: 13.5,
                        fontWeight:
                            active ? FontWeight.w700 : FontWeight.w500,
                        color:
                            active ? AppColors.accent : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.type.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (active)
                const Icon(
                  Icons.chevron_left_rounded,
                  size: 18,
                  color: AppColors.accent,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PeriodChip extends StatefulWidget {
  const _PeriodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_PeriodChip> createState() => _PeriodChipState();
}

class _PeriodChipState extends State<_PeriodChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool active = widget.selected;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary
                : _hovered
                    ? AppColors.surfaceAlt
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm + 2),
            border: Border.all(
              color: active ? AppColors.primary : AppColors.border,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// خلية فيها المبلغ وتحته شريط نسبي
class _BarCell extends StatelessWidget {
  const _BarCell({
    required this.value,
    required this.max,
    this.color = AppColors.accent,
  });

  final double value;
  final double max;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Fmt.money(value),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppText.amountSm.copyWith(fontSize: 13),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: SizedBox(
            height: 5,
            child: Stack(
              children: <Widget>[
                Container(color: AppColors.surfaceAlt),
                FractionallySizedBox(
                  widthFactor: max == 0 ? 0 : (value / max).clamp(0, 1),
                  child: Container(color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// خلية هامش الربح بلون حسب قوّته
class _MarginCell extends StatelessWidget {
  const _MarginCell({required this.margin});

  final double margin;

  @override
  Widget build(BuildContext context) {
    final Color color = margin >= 30
        ? AppColors.success
        : margin >= 18
            ? AppColors.warning
            : AppColors.danger;

    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: color.withValues(alpha: 0.22)),
          ),
          child: Text(
            Fmt.percent(margin),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// رسم أعمدة المبيعات
// ═══════════════════════════════════════════════════════════════════════════

class _SalesBarChart extends StatelessWidget {
  const _SalesBarChart({required this.points, required this.weekly});

  final List<SalesPoint> points;
  final bool weekly;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) return const SizedBox.shrink();

    final double maxY = points
            .map((SalesPoint p) => p.sales)
            .reduce((double a, double b) => a > b ? a : b) *
        1.2;
    final double labelInterval = (points.length / 8).ceilToDouble();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: AppDecorations.card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: AppRadius.smAll,
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  size: 18,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('حركة المبيعات', style: AppText.sectionTitle),
                    const SizedBox(height: 2),
                    Text(
                      weekly ? 'مجمّعة أسبوعيًا' : 'يوميًا',
                      style: AppText.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: maxY,
                alignment: BarChartAlignment.spaceAround,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxY / 4,
                  getDrawingHorizontalLine: (double value) => const FlLine(
                    color: AppColors.border,
                    strokeWidth: 1,
                    dashArray: <int>[6, 6],
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 52,
                      interval: maxY / 4,
                      getTitlesWidget: (double value, TitleMeta meta) =>
                          Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.sm),
                        child: Text(
                          Fmt.compact(value),
                          style: AppText.caption.copyWith(fontSize: 10.5),
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: labelInterval,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final int i = value.round();
                        if (i < 0 || i >= points.length) {
                          return const SizedBox.shrink();
                        }
                        final DateTime d = points[i].date;
                        return Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          child: Text(
                            '${d.day}/${d.month}',
                            style: AppText.caption.copyWith(fontSize: 10.5),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (BarChartGroupData group) =>
                        AppColors.primary,
                    tooltipBorderRadius:
                        BorderRadius.circular(AppRadius.sm),
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) =>
                        BarTooltipItem(
                      Fmt.money(rod.toY),
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\n${Fmt.date(points[groupIndex].date)}',
                          style: const TextStyle(
                            color: AppColors.textOnDarkMuted,
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                barGroups: <BarChartGroupData>[
                  for (int i = 0; i < points.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: <BarChartRodData>[
                        BarChartRodData(
                          toY: points[i].sales,
                          width: points.length > 30 ? 6 : 14,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              Color(0xFF8B5CF6),
                              AppColors.accent,
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
