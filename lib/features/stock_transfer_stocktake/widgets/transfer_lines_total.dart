import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/stock_transfer_controller.dart';

/// سطر الإجمالي أسفل جدول الأصناف.
class TransferLinesTotal extends StatelessWidget {
  const TransferLinesTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final StockTransferController transfer =
        context.watch<StockTransferController>();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceAlt,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: <Widget>[
          Text(
            'إجمالي ${Fmt.count(transfer.totalQuantity)} وحدة',
            style: AppText.bodyMedium.copyWith(fontSize: 13),
          ),
          const Spacer(),
          Text('القيمة الإجمالية:', style: AppText.caption),
          const SizedBox(width: AppSpacing.sm),
          Text(Fmt.money(transfer.totalValue), style: AppText.amountMd),
        ],
      ),
    );
  }
}
