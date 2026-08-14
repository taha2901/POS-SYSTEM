import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/stock_transfer_controller.dart';
import '../models/transfer_status.dart';

/// فوتر الحوار: اتجاه التحويل وأزرار الإلغاء والتقدّم للمرحلة اللي بعدها.
class TransferFooter extends StatelessWidget {
  const TransferFooter({super.key});

  void _advance(BuildContext context) {
    final bool finished = context.read<StockTransferController>().advance();
    if (finished) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final StockTransferController transfer =
        context.watch<StockTransferController>();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppRadius.xl),
          bottomLeft: Radius.circular(AppRadius.xl),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  transfer.status.icon,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    '${transfer.from.name}  ←  ${transfer.to.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.caption.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          SecondaryButton(
            label: 'إلغاء',
            size: AppButtonSize.large,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: AppSpacing.md),
          PrimaryButton(
            label: transfer.status.actionLabel,
            icon: transfer.status == TransferStatus.received
                ? Icons.check_rounded
                : Icons.send_rounded,
            size: AppButtonSize.large,
            onPressed: transfer.canSubmit ? () => _advance(context) : null,
          ),
        ],
      ),
    );
  }
}
