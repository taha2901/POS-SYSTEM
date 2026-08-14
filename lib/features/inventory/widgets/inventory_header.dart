import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../../stock_transfer_stocktake/screens/stock_transfer_dialog.dart';

/// هيدر شاشة المخزون: العنوان وأزرار التحويل والجرد.
class InventoryHeader extends StatelessWidget {
  const InventoryHeader({super.key});

  Future<void> _openTransferDialog(BuildContext context) async {
    final bool? done = await showStockTransferDialog(context);
    if (done != true || !context.mounted) return;

    showPlainSnackBar(context, 'تم تنفيذ أمر تحويل المخزون (تجريبي)');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'نظرة عامة على المخزون',
                style: AppText.pageTitle.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 3),
              Text(
                'متابعة الأرصدة والحركات عبر كل الفروع والمخازن',
                style: AppText.caption,
              ),
            ],
          ),
        ),
        SecondaryButton(
          label: 'تحويل مخزون',
          icon: Icons.swap_horiz_rounded,
          onPressed: () => _openTransferDialog(context),
        ),
        const SizedBox(width: AppSpacing.md),
        SecondaryButton(
          label: 'بدء جرد',
          icon: Icons.fact_check_outlined,
          tone: SecondaryButtonTone.accent,
          onPressed: () => context.go('/inventory/stocktake'),
        ),
      ],
    );
  }
}
