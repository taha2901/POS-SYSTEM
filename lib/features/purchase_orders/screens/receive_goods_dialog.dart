import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/receive_goods_controller.dart';
import '../widgets/receive_goods_footer.dart';
import '../widgets/receive_goods_header.dart';
import '../widgets/receive_lines_table.dart';
import '../widgets/receive_progress_bar.dart';

/// يفتح Modal استلام البضاعة لأمر شراء مؤكد.
Future<bool?> showReceiveGoodsDialog(
  BuildContext context,
  PurchaseOrder order,
) {
  return showDialog<bool>(
    context: context,
    barrierColor: AppColors.primary.withValues(alpha: 0.45),
    builder: (BuildContext context) => ReceiveGoodsDialog(order: order),
  );
}

/// حوار الاستلام — بيجمّع الهيدر وشريط التقدّم والجدول والفوتر بس.
class ReceiveGoodsDialog extends StatelessWidget {
  const ReceiveGoodsDialog({super.key, required this.order});

  final PurchaseOrder order;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.sizeOf(context);

    return ChangeNotifierProvider<ReceiveGoodsController>(
      create: (_) => ReceiveGoodsController(order: order),
      child: Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.xxl),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 940,
            maxHeight: screen.height - 80,
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ReceiveGoodsHeader(),
              ReceiveProgressBar(),
              Flexible(child: ReceiveLinesTable()),
              ReceiveGoodsFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
