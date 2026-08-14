import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_data_table.dart';
import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/hover_row_action.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/employees_list_controller.dart';
import 'employee_role_cell.dart';
import 'employees_table_footer.dart';

/// جدول الموظفين.
class EmployeesTable extends StatelessWidget {
  const EmployeesTable({super.key});

  static const List<AppTableColumn> _columns = <AppTableColumn>[
    AppTableColumn('الموظف', size: ColumnSize.L, sortable: true),
    AppTableColumn('الدور', size: ColumnSize.M, sortable: true),
    AppTableColumn('الفرع', size: ColumnSize.M, sortable: true),
    AppTableColumn('الحالة', size: ColumnSize.S, sortable: true),
    AppTableColumn('آخر دخول', size: ColumnSize.M, sortable: true),
    AppTableColumn('', fixedWidth: 110),
  ];

  List<Widget> _cells(BuildContext context, Employee e, bool hovered) {
    return <Widget>[
      TableCells.avatarName(
        e.name,
        e.initials,
        color: e.isActive ? AppColors.accent : AppColors.textMuted,
        subtitle: e.phone,
      ),
      EmployeeRoleCell(employee: e),
      Text(
        e.branchName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppText.body.copyWith(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
      ),
      StatusBadge(
        label: e.isActive ? 'نشط' : 'موقوف',
        tone: e.isActive ? StatusTone.success : StatusTone.neutral,
      ),
      TableCells.twoLine(Fmt.date(e.lastLogin), Fmt.time(e.lastLogin)),
      HoverRowAction(
        hovered: hovered,
        child: SecondaryButton(
          label: 'الصلاحيات',
          size: AppButtonSize.small,
          tone: SecondaryButtonTone.accent,
          onPressed: () => context.go('/employees/roles'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final EmployeesListController employees =
        context.watch<EmployeesListController>();

    return AppDataTable(
      minWidth: 1040,
      rowHeight: 66,
      sortColumnIndex: employees.sortIndex,
      sortAscending: employees.sortAscending,
      onSort: employees.sortBy,
      emptyMessage: 'لا يوجد موظفون مطابقون للبحث',
      emptyIcon: Icons.badge_outlined,
      columns: _columns,
      rows: <AppTableRow>[
        for (final Employee e in employees.rows)
          AppTableRow(
            onTap: () => showPlainSnackBar(context, 'عرض ملف ${e.name}'),
            cellsBuilder: (bool hovered) => _cells(context, e, hovered),
          ),
      ],
      footer: const EmployeesTableFooter(),
    );
  }
}
