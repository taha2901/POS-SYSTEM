import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_data_table.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../theme/app_theme.dart';
import '../controllers/reports_controller.dart';
import '../models/employee_report_row.dart';
import '../models/report_period.dart';
import 'bar_cell.dart';

/// جدول أداء الموظفين.
class EmployeesReportTable extends StatelessWidget {
  const EmployeesReportTable({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController reports = context.watch<ReportsController>();
    final List<EmployeeReportRow> rows = reports.employeeRows;

    final double maxSales =
        rows.isEmpty || rows.first.sales == 0 ? 1 : rows.first.sales;

    return AppDataTable(
      title: 'أداء الموظفين',
      subtitle: 'المبيعات موزّعة على الفريق خلال ${reports.period.label}',
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
        for (final EmployeeReportRow r in rows)
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
              BarCell(value: r.sales, max: maxSales),
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
    );
  }
}
