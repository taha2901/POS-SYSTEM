import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/sales_session_controller.dart';
import 'held_invoices_dialog.dart';

/// زرار الفواتير المعلّقة — بيعرض عدّادها وبيفتح قائمتها.
class HeldInvoicesButton extends StatelessWidget {
  const HeldInvoicesButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesSessionController session =
        context.watch<SalesSessionController>();
    final int count = session.heldCount;
    final bool hasHeld = count > 0;

    return Tooltip(
      message: hasHeld
          ? '$count فاتورة معلّقة'
          : 'مفيش فواتير معلّقة',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: hasHeld ? () => showHeldInvoicesDialog(context) : null,
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: hasHeld ? AppColors.warningSoft : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.sm + 2),
              border: Border.all(
                color: hasHeld
                    ? AppColors.warning.withValues(alpha: 0.4)
                    : AppColors.border,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.pause_circle_outline_rounded,
                  size: 16,
                  color: hasHeld ? AppColors.warning : AppColors.textMuted,
                ),
                if (hasHeld) ...<Widget>[
                  const SizedBox(width: 5),
                  Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
