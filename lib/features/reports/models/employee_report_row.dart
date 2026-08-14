import '../../../mock_data/mock_data.dart';

/// سطر أداء موظف — مبيعات الفترة موزّعة حسب مبيعات اليوم.
class EmployeeReportRow {
  const EmployeeReportRow({
    required this.employee,
    required this.sales,
    required this.invoices,
  });

  final Employee employee;
  final double sales;
  final int invoices;
}
