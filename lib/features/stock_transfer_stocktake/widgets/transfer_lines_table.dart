import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/product_picker_dialog.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/stock_transfer_controller.dart';
import '../models/transfer_line.dart';
import 'transfer_line_row.dart';
import 'transfer_lines_empty.dart';
import 'transfer_lines_header.dart';
import 'transfer_lines_total.dart';

/// جدول الأصناف المحوّلة مع زرار الإضافة والإجمالي.
class TransferLinesTable extends StatelessWidget {
  const TransferLinesTable({super.key});

  Future<void> _addProduct(BuildContext context) async {
    final StockTransferController transfer =
        context.read<StockTransferController>();

    final Product? product = await showProductPicker(
      context,
      excludedIds: transfer.pickedProductIds,
    );
    if (product == null) return;

    transfer.addProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    final StockTransferController transfer =
        context.watch<StockTransferController>();
    final List<TransferLine> lines = transfer.lines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('الأصناف المحوّلة', style: AppText.cardTitle),
            const SizedBox(width: AppSpacing.sm),
            if (lines.isNotEmpty)
              Text('(${Fmt.count(lines.length)})', style: AppText.caption),
            const Spacer(),
            SecondaryButton(
              label: 'إضافة صنف',
              icon: Icons.add_rounded,
              size: AppButtonSize.small,
              tone: SecondaryButtonTone.accent,
              onPressed:
                  transfer.isEditable ? () => _addProduct(context) : null,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: AppDecorations.card(radius: AppRadius.md),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              const TransferLinesHeader(),
              if (lines.isEmpty)
                const TransferLinesEmpty()
              else
                for (int i = 0; i < lines.length; i++)
                  TransferLineRow(
                    key: ObjectKey(lines[i]),
                    line: lines[i],
                    isLast: i == lines.length - 1,
                  ),
              if (lines.isNotEmpty) const TransferLinesTotal(),
            ],
          ),
        ),
      ],
    );
  }
}
