import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/purchase_order_status_tone.dart';
import '../../../core/widgets/app_data_table.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// التبويب التالت: أوامر الشراء الخاصة بالمورد.
class SupplierOrdersTab extends StatelessWidget {
  const SupplierOrdersTab({super.key, required this.supplier});

  final Supplier supplier;

  @override
  Widget build(BuildContext context) {
    final List<PurchaseOrder> orders = MockData.purchaseOrders
        .where((PurchaseOrder o) => o.supplierId == supplier.id)
        .toList(growable: false);

    return AppDataTable(
      title: 'أوامر الشراء',
      subtitle: '${Fmt.count(orders.length)} أمر توريد',
      minWidth: 820,
      rowHeight: 60,
      emptyMessage: 'لا توجد أوامر شراء لهذا المورد',
      emptyIcon: Icons.shopping_cart_outlined,
      columns: const <AppTableColumn>[
        AppTableColumn('رقم الأمر', size: ColumnSize.S),
        AppTableColumn('التاريخ', size: ColumnSize.M),
        AppTableColumn('عدد الأصناف', size: ColumnSize.S, numeric: true),
        AppTableColumn('الحالة', size: ColumnSize.M),
        AppTableColumn('الإجمالي', size: ColumnSize.M, numeric: true),
      ],
      rows: <AppTableRow>[
        for (final PurchaseOrder o in orders)
          AppTableRow(
            onTap: () => context.go('/purchases'),
            cells: <Widget>[
              Text(o.id, style: AppText.amountSm.copyWith(fontSize: 13)),
              TableCells.twoLine(
                Fmt.date(o.date),
                'التسليم: ${Fmt.date(o.expectedDate)}',
              ),
              TableCells.count(o.lines.length),
              StatusBadge(label: o.status.label, tone: o.status.tone),
              TableCells.amount(o.total),
            ],
          ),
      ],
      footer: Row(
        children: <Widget>[
          Text('إجمالي قيمة الأوامر', style: AppText.caption),
          const Spacer(),
          Text(
            Fmt.money(
              orders.fold<double>(
                0,
                (double sum, PurchaseOrder o) => sum + o.total,
              ),
            ),
            style: AppText.amountMd,
          ),
        ],
      ),
    );
  }
}
