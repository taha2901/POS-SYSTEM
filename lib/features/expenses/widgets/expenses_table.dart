import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_data_table.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/expenses_controller.dart';
import 'expense_category_badge.dart';
import 'expenses_table_footer.dart';

/// جدول المصروفات.
class ExpensesTable extends StatelessWidget {
  const ExpensesTable({super.key});

  static const List<AppTableColumn> _columns = <AppTableColumn>[
    AppTableColumn('التاريخ', size: ColumnSize.M, sortable: true),
    AppTableColumn('الفئة', size: ColumnSize.M, sortable: true),
    AppTableColumn('الفرع', size: ColumnSize.M, sortable: true),
    AppTableColumn('الملاحظة', size: ColumnSize.L),
    AppTableColumn('المبلغ', size: ColumnSize.S, sortable: true, numeric: true),
    AppTableColumn('الحالة', size: ColumnSize.S, sortable: true),
  ];

  List<Widget> _cells(Expense e) {
    return <Widget>[
      TableCells.twoLine(Fmt.date(e.date), e.id),
      ExpenseCategoryBadge(category: e.category),
      Text(
        e.branch?.name ?? '—',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppText.body.copyWith(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
      ),
      Text(
        e.note,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppText.body.copyWith(fontSize: 13),
      ),
      TableCells.amount(e.amount, color: AppColors.danger),
      StatusBadge(
        label: e.status.label,
        tone: e.status == ExpenseStatus.approved
            ? StatusTone.success
            : StatusTone.warning,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ExpensesController expenses = context.watch<ExpensesController>();

    return AppDataTable(
      minWidth: 1000,
      rowHeight: 62,
      sortColumnIndex: expenses.sortIndex,
      sortAscending: expenses.sortAscending,
      onSort: expenses.sortBy,
      emptyMessage: 'لا توجد مصروفات مطابقة للفلتر',
      emptyIcon: Icons.receipt_long_outlined,
      columns: _columns,
      rows: <AppTableRow>[
        for (final Expense e in expenses.rows) AppTableRow(cells: _cells(e)),
      ],
      footer: const ExpensesTableFooter(),
    );
  }
}
