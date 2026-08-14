import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../models/branch_performance.dart';
import '../models/dashboard_period.dart';
import '../models/payment_slice.dart';

/// حالة لوحة التحكم: الفترة الزمنية والفرع المختارين.
class DashboardController extends ChangeNotifier {
  DashboardController({required TickerProvider vsync}) {
    entryController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  /// أنيميشن الدخول المتدرّج لكل عناصر الصفحة
  late final AnimationController entryController;

  DashboardPeriod _period = DashboardPeriod.month;
  String? _branchId;

  DashboardPeriod get period => _period;
  String? get branchId => _branchId;

  void setPeriod(DashboardPeriod period) {
    _period = period;
    notifyListeners();
  }

  void setBranch(String? id) {
    _branchId = id;
    notifyListeners();
  }

  // ── السلاسل الزمنية ──────────────────────────────────────────────────────
  List<SalesPoint> get current =>
      MockData.seriesFor(days: _period.days, branchId: _branchId);

  List<SalesPoint> get previous => MockData.seriesFor(
        days: _period.days,
        branchId: _branchId,
        offset: 1,
      );

  double _sum(List<SalesPoint> s, double Function(SalesPoint) f) =>
      s.fold<double>(0, (double acc, SalesPoint p) => acc + f(p));

  int _invoicesIn(List<SalesPoint> s) =>
      s.fold<int>(0, (int acc, SalesPoint p) => acc + p.invoices);

  // ── أرقام الفترة الحالية ─────────────────────────────────────────────────
  double get sales => _sum(current, (SalesPoint p) => p.sales);
  double get profit => _sum(current, (SalesPoint p) => p.profit);
  int get invoices => _invoicesIn(current);
  double get avgInvoice => invoices == 0 ? 0 : sales / invoices;

  double get profitMargin => sales == 0 ? 0 : (profit / sales) * 100;

  // ── نِسَب التغيّر عن الفترة السابقة ───────────────────────────────────────
  double _changeVs(double current, double previous) {
    if (previous == 0) return current == 0 ? 0 : 100;
    return ((current - previous) / previous) * 100;
  }

  double get salesChange =>
      _changeVs(sales, _sum(previous, (SalesPoint p) => p.sales));

  double get profitChange =>
      _changeVs(profit, _sum(previous, (SalesPoint p) => p.profit));

  double get invoicesChange => _changeVs(
        invoices.toDouble(),
        _invoicesIn(previous).toDouble(),
      );

  double get avgInvoiceChange {
    final List<SalesPoint> prev = previous;
    final int prevInvoices = _invoicesIn(prev);
    final double prevAvg = prevInvoices == 0
        ? 0
        : _sum(prev, (SalesPoint p) => p.sales) / prevInvoices;
    return _changeVs(avgInvoice, prevAvg);
  }

  // ── بيانات الرسوم والجداول ───────────────────────────────────────────────
  List<PaymentSlice> get paymentSlices {
    final List<SalesPoint> p = current;
    double sum(double Function(SalesPoint) f) =>
        p.fold<double>(0, (double acc, SalesPoint x) => acc + f(x));

    return <PaymentSlice>[
      PaymentSlice(
        label: 'كاش',
        value: sum((SalesPoint x) => x.cash),
        color: AppColors.success,
        icon: Icons.payments_rounded,
      ),
      PaymentSlice(
        label: 'بطاقة',
        value: sum((SalesPoint x) => x.card),
        color: AppColors.info,
        icon: Icons.credit_card_rounded,
      ),
      PaymentSlice(
        label: 'محفظة',
        value: sum((SalesPoint x) => x.wallet),
        color: AppColors.accent,
        icon: Icons.account_balance_wallet_rounded,
      ),
      PaymentSlice(
        label: 'آجل',
        value: sum((SalesPoint x) => x.credit),
        color: AppColors.warning,
        icon: Icons.schedule_rounded,
      ),
    ];
  }

  List<ProductSalesStat> get topProducts =>
      MockData.topProducts(count: 5, days: _period.days);

  /// الفروع مرتّبة تنازليًا حسب المبيعات.
  List<BranchPerformance> get branchesPerformance {
    return <BranchPerformance>[
      for (final Branch b in MockData.branches)
        BranchPerformance(
          branch: b,
          sales: MockData.seriesFor(days: _period.days, branchId: b.id)
              .fold<double>(0, (double s, SalesPoint p) => s + p.sales),
          change: 4.2 + (MockData.branches.indexOf(b) * 5.6),
        ),
    ]..sort(
        (BranchPerformance a, BranchPerformance b) =>
            b.sales.compareTo(a.sales),
      );
  }

  @override
  void dispose() {
    entryController.dispose();
    super.dispose();
  }
}
