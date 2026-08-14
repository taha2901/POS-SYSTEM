import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/stock_transfer_controller.dart';
import '../widgets/transfer_branches_row.dart';
import '../widgets/transfer_footer.dart';
import '../widgets/transfer_header.dart';
import '../widgets/transfer_lines_table.dart';

/// يفتح حوار تحويل المخزون بين الفروع.
Future<bool?> showStockTransferDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierColor: AppColors.primary.withValues(alpha: 0.45),
    builder: (BuildContext context) => const StockTransferDialog(),
  );
}

/// حوار التحويل — بيجمّع الهيدر والفروع وجدول الأصناف والفوتر بس.
class StockTransferDialog extends StatelessWidget {
  const StockTransferDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.sizeOf(context);

    return ChangeNotifierProvider<StockTransferController>(
      create: (_) => StockTransferController(),
      child: Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.xxl),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 900,
            maxHeight: screen.height - 80,
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TransferHeader(),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.xxl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TransferBranchesRow(),
                      SizedBox(height: AppSpacing.xxl),
                      TransferLinesTable(),
                    ],
                  ),
                ),
              ),
              TransferFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
