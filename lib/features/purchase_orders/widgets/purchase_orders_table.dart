import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/purchase_order_status_tone.dart';
import '../../../core/widgets/app_data_table.dart';
import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/purchase_orders_controller.dart';
import '../screens/receive_goods_dialog.dart';
import 'purchase_order_row_action.dart';
import 'purchase_order_supplier_cell.dart';
import 'purchase_orders_table_footer.dart';
import 'receive_progress_cell.dart';

/// جدول أوامر الشراء.
class PurchaseOrdersTable extends StatelessWidget {
  const PurchaseOrdersTable({super.key});

  static const List<AppTableColumn> _columns = <AppTableColumn>[
    AppTableColumn('رقم الأمر', size: ColumnSize.S, sortable: true),
    AppTableColumn('المورد', size: ColumnSize.L, sortable: true),
    AppTableColumn('التاريخ', size: ColumnSize.M, sortable: true),
    AppTableColumn('الحالة', size: ColumnSize.M, sortable: true),
    AppTableColumn('نسبة الاستلام', size: ColumnSize.M),
    AppTableColumn(
      'الإجمالي',
      size: ColumnSize.M,
      sortable: true,
      numeric: true,
    ),
    AppTableColumn('', fixedWidth: 120),
  ];

  /// الأوامر القابلة للاستلام بس هي اللي بتفتح حوار الاستلام.
  Future<void> _openOrder(BuildContext context, PurchaseOrder order) async {
    if (!order.isReceivable) {
      showPlainSnackBar(
        context,
        order.status == PurchaseOrderStatus.draft
            ? 'الأمر ${order.id} لسه مسودة — أكّده الأول عشان تستلمه'
            : 'الأمر ${order.id} مستلم بالكامل',
        width: 460,
      );
      return;
    }

    final bool? received = await showReceiveGoodsDialog(context, order);
    if (received != true || !context.mounted) return;

    showPlainSnackBar(
      context,
      'تم تسجيل استلام البضاعة للأمر ${order.id} (تجريبي)',
      width: 460,
    );
  }

  List<Widget> _cells(BuildContext context, PurchaseOrder o, bool hovered) {
    return <Widget>[
      Text(o.id, style: AppText.amountSm.copyWith(fontSize: 13.5)),
      PurchaseOrderSupplierCell(order: o),
      TableCells.twoLine(
        Fmt.date(o.date),
        'التسليم: ${Fmt.date(o.expectedDate)}',
      ),
      StatusBadge(label: o.status.label, tone: o.status.tone),
      ReceiveProgressCell(ratio: o.receivedRatio),
      Text(Fmt.money(o.total), style: AppText.amountSm),
      PurchaseOrderRowAction(
        order: o,
        hovered: hovered,
        onPressed: () => _openOrder(context, o),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final PurchaseOrdersController orders =
        context.watch<PurchaseOrdersController>();

    return AppDataTable(
      minWidth: 1080,
      rowHeight: 66,
      sortColumnIndex: orders.sortIndex,
      sortAscending: orders.sortAscending,
      onSort: orders.sortBy,
      emptyMessage: 'لا توجد أوامر شراء مطابقة',
      emptyIcon: Icons.shopping_cart_outlined,
      columns: _columns,
      rows: <AppTableRow>[
        for (final PurchaseOrder o in orders.rows)
          AppTableRow(
            onTap: () => _openOrder(context, o),
            cellsBuilder: (bool hovered) => _cells(context, o, hovered),
          ),
      ],
      footer: const PurchaseOrdersTableFooter(),
    );
  }
}
