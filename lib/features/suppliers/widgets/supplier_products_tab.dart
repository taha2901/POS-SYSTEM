import 'package:flutter/material.dart';

import '../../../core/widgets/app_data_table.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import 'supplier_product_cell.dart';

/// التبويب الأول: المنتجات اللي بيوردها المورد.
class SupplierProductsTab extends StatelessWidget {
  const SupplierProductsTab({super.key, required this.supplier});

  final Supplier supplier;

  @override
  Widget build(BuildContext context) {
    final List<Product> products = MockData.productsBySupplier(supplier.id);

    return AppDataTable(
      title: 'المنتجات الموردة',
      subtitle: '${Fmt.count(products.length)} صنف يتم توريده من هذا المورد',
      minWidth: 900,
      rowHeight: 60,
      emptyMessage: 'لا توجد منتجات مرتبطة بهذا المورد',
      emptyIcon: Icons.inventory_2_outlined,
      columns: const <AppTableColumn>[
        AppTableColumn('المنتج', size: ColumnSize.L),
        AppTableColumn('SKU', size: ColumnSize.S),
        AppTableColumn('الفئة', size: ColumnSize.M),
        AppTableColumn('سعر الشراء', size: ColumnSize.S, numeric: true),
        AppTableColumn('سعر البيع', size: ColumnSize.S, numeric: true),
        AppTableColumn('المخزون', size: ColumnSize.S, numeric: true),
      ],
      rows: <AppTableRow>[
        for (final Product p in products)
          AppTableRow(
            cells: <Widget>[
              SupplierProductCell(product: p),
              TableCells.secondary(p.sku),
              TableCells.secondary(p.categoryName),
              // سعر الشراء بلون مميّز لأنه العمود المهم هنا
              Text(
                Fmt.money(p.cost),
                style: AppText.amountSm.copyWith(color: AppColors.accent),
              ),
              TableCells.amount(p.price),
              Text(
                '${Fmt.count(p.stock)} ${p.unit}',
                style: AppText.amountSm.copyWith(
                  color: p.isLowStock || p.isOutOfStock
                      ? AppColors.danger
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),
      ],
      footer: Row(
        children: <Widget>[
          Text('متوسط هامش الربح على أصناف المورد', style: AppText.caption),
          const Spacer(),
          Text(
            products.isEmpty
                ? '—'
                : Fmt.percent(
                    products.fold<double>(
                          0,
                          (double sum, Product p) => sum + p.profitMargin,
                        ) /
                        products.length,
                  ),
            style: AppText.amountMd.copyWith(color: AppColors.success),
          ),
        ],
      ),
    );
  }
}
