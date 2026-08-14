/// الفترات الزمنية المتاحة في التقارير.
enum ReportPeriod { week, month, quarter, year }

extension ReportPeriodInfo on ReportPeriod {
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
