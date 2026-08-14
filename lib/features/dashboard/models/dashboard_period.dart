/// الفترات الزمنية المتاحة للفلترة في لوحة التحكم.
enum DashboardPeriod { today, week, month, quarter, year }

extension DashboardPeriodInfo on DashboardPeriod {
  String get label => switch (this) {
        DashboardPeriod.today => 'اليوم',
        DashboardPeriod.week => 'آخر 7 أيام',
        DashboardPeriod.month => 'آخر 30 يوم',
        DashboardPeriod.quarter => 'آخر 90 يوم',
        DashboardPeriod.year => 'آخر سنة',
      };

  int get days => switch (this) {
        DashboardPeriod.today => 1,
        DashboardPeriod.week => 7,
        DashboardPeriod.month => 30,
        DashboardPeriod.quarter => 90,
        DashboardPeriod.year => 365,
      };

  String get comparisonLabel => switch (this) {
        DashboardPeriod.today => 'مقارنة بأمس',
        DashboardPeriod.week => 'مقارنة بالأسبوع السابق',
        DashboardPeriod.month => 'مقارنة بالشهر السابق',
        DashboardPeriod.quarter => 'مقارنة بالربع السابق',
        DashboardPeriod.year => 'مقارنة بالسنة السابقة',
      };
}
