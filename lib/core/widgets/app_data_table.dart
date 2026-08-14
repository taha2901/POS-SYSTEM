import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/formatters.dart';

export 'package:data_table_2/data_table_2.dart' show ColumnSize;

/// وصف عمود في الجدول.
class AppTableColumn {
  const AppTableColumn(
    this.label, {
    this.size = ColumnSize.M,
    this.fixedWidth,
    this.numeric = false,
    this.sortable = false,
    this.tooltip,
  });

  final String label;
  final ColumnSize size;
  final double? fixedWidth;
  final bool numeric;
  final bool sortable;
  final String? tooltip;
}

/// صف في الجدول — عدد الخلايا لازم يساوي عدد الأعمدة.
///
/// استخدم [cells] للصفوف العادية، أو [cellsBuilder] لو محتاج تعرف إذا كان
/// الماوس فوق الصف (مثلاً عشان تظهر أيقونات التعديل والحذف عند الـHover).
class AppTableRow {
  const AppTableRow({
    this.cells,
    this.cellsBuilder,
    this.onTap,
    this.selected = false,
    this.highlightColor,
  }) : assert(
          cells != null || cellsBuilder != null,
          'لازم تمرّر cells أو cellsBuilder',
        );

  final List<Widget>? cells;
  final List<Widget> Function(bool hovered)? cellsBuilder;
  final VoidCallback? onTap;
  final bool selected;

  /// لتمييز صف بلون خفيف (مثلاً صف مخزون ناقص)
  final Color? highlightColor;

  List<Widget> buildCells(bool hovered) =>
      cellsBuilder?.call(hovered) ?? cells!;
}

/// جدول بيانات موحّد: Header ثابت، فرز، وHover على الصفوف.
///
/// لازم يتحطّ جوه Widget بارتفاع محدد (Expanded أو SizedBox)
/// أو استخدم الـ`height` parameter.
class AppDataTable extends StatefulWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.title,
    this.subtitle,
    this.actions = const <Widget>[],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSort,
    this.minWidth = 900,
    this.rowHeight = 60,
    this.headingHeight = 48,
    this.emptyMessage = 'لا توجد بيانات لعرضها',
    this.emptyIcon = Icons.inbox_outlined,
    this.height,
    this.footer,
  });

  final List<AppTableColumn> columns;
  final List<AppTableRow> rows;
  final String? title;
  final String? subtitle;
  final List<Widget> actions;
  final int? sortColumnIndex;
  final bool sortAscending;
  final void Function(int columnIndex, bool ascending)? onSort;
  final double minWidth;
  final double rowHeight;
  final double headingHeight;
  final String emptyMessage;
  final IconData emptyIcon;
  final double? height;
  final Widget? footer;

  @override
  State<AppDataTable> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTable> {
  /// الصف اللي الماوس فوقه دلوقتي — بيتمرّر لـ`cellsBuilder`
  int? _hoveredRow;

  @override
  Widget build(BuildContext context) {
    final Widget card = Container(
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.title != null || widget.actions.isNotEmpty)
            _buildHeader(),
          Expanded(
            child: MouseRegion(
              onExit: (_) {
                if (_hoveredRow != null) {
                  setState(() => _hoveredRow = null);
                }
              },
              child: _buildTable(),
            ),
          ),
          if (widget.footer != null) ...<Widget>[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              child: widget.footer,
            ),
          ],
        ],
      ),
    );

    return widget.height != null
        ? SizedBox(height: widget.height, child: card)
        : card;
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.title != null)
                  Text(widget.title!, style: AppText.sectionTitle),
                if (widget.subtitle != null) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(widget.subtitle!, style: AppText.caption),
                ],
              ],
            ),
          ),
          ...widget.actions.expand(
            (Widget w) => <Widget>[const SizedBox(width: AppSpacing.sm), w],
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return DataTable2(
      columnSpacing: AppSpacing.xl,
      horizontalMargin: AppSpacing.xl,
      minWidth: widget.minWidth,
      dataRowHeight: widget.rowHeight,
      headingRowHeight: widget.headingHeight,
      dividerThickness: 1,
      showCheckboxColumn: false,
      sortColumnIndex: widget.sortColumnIndex,
      sortAscending: widget.sortAscending,
      sortArrowIcon: Icons.keyboard_arrow_up_rounded,
      sortArrowIconColor: AppColors.accent,
      headingRowDecoration: const BoxDecoration(color: AppColors.surfaceAlt),
      headingTextStyle: AppText.label.copyWith(fontSize: 12.5),
      dataTextStyle: AppText.body,
      border: TableBorder(
        horizontalInside: BorderSide(
          color: AppColors.border.withValues(alpha: 0.7),
        ),
      ),
      empty: _EmptyState(
        message: widget.emptyMessage,
        icon: widget.emptyIcon,
      ),
      columns: <DataColumn2>[
        for (final AppTableColumn c in widget.columns)
          DataColumn2(
            label: Text(c.label),
            size: c.size,
            fixedWidth: c.fixedWidth,
            numeric: c.numeric,
            tooltip: c.tooltip,
            onSort: c.sortable ? widget.onSort : null,
          ),
      ],
      rows: <DataRow2>[
        for (int i = 0; i < widget.rows.length; i++)
          _buildRow(widget.rows[i], i),
      ],
    );
  }

  DataRow2 _buildRow(AppTableRow row, int index) {
    final bool hovered = _hoveredRow == index;

    return DataRow2(
      selected: row.selected,
      onTap: row.onTap ?? () {},
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentSoft;
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.surfaceHover;
          }
          return row.highlightColor;
        },
      ),
      cells: <DataCell>[
        for (final Widget cell in row.buildCells(hovered))
          DataCell(
            MouseRegion(
              opaque: false,
              onEnter: (_) {
                if (_hoveredRow != index) {
                  setState(() => _hoveredRow = index);
                }
              },
              child: cell,
            ),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message, required this.icon});

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.surfaceAlt,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            message,
            style: AppText.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// خلايا جاهزة عشان كل الجداول تبقى بنفس الشكل.
class TableCells {
  const TableCells._();

  static Widget primary(String text, {int maxLines = 1}) => Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: AppText.bodyMedium,
      );

  static Widget secondary(String text) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppText.caption,
      );

  static Widget amount(num value, {Color? color, bool withSymbol = true}) =>
      Text(
        withSymbol ? Fmt.money(value) : Fmt.amount(value),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppText.amountSm.copyWith(color: color ?? AppColors.textPrimary),
      );

  static Widget count(num value) => Text(
        Fmt.count(value),
        maxLines: 1,
        style: AppText.amountSm,
      );

  /// خلية فيها عنوان أساسي وتحته سطر رمادي صغير
  static Widget twoLine(String primaryText, String secondaryText) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            primaryText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.bodyMedium,
          ),
          const SizedBox(height: 2),
          Text(
            secondaryText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption.copyWith(fontSize: 11.5),
          ),
        ],
      );

  /// خلية بأفاتار دائري + اسم
  static Widget avatarName(
    String name,
    String initials, {
    Color color = AppColors.accent,
    String? subtitle,
  }) =>
      Row(
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Text(
              initials,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: subtitle == null
                ? primary(name)
                : twoLine(name, subtitle),
          ),
        ],
      );
}
