import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/stock_transfer_controller.dart';
import '../models/transfer_status.dart';
import 'transfer_step_circle.dart';

/// شريط مراحل التحويل الثلاثة.
class TransferStepper extends StatelessWidget {
  const TransferStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context
        .select((StockTransferController t) => t.status.index);

    return Row(
      children: <Widget>[
        for (int i = 0; i < TransferStatus.values.length; i++) ...<Widget>[
          TransferStepCircle(
            status: TransferStatus.values[i],
            index: i,
            currentIndex: currentIndex,
          ),
          if (i != TransferStatus.values.length - 1)
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: i < currentIndex
                      ? AppColors.accent
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
