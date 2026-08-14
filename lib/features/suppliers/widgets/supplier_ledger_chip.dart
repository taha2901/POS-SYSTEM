import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// شارة مبلغ في رأس كشف حساب المورد.
class SupplierLedgerChip extends StatelessWidget {
  const SupplierLedgerChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md - 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label, style: AppText.caption.copyWith(fontSize: 12)),
          const SizedBox(width: AppSpacing.md),
          Text(
            value,
            style: AppText.amountMd.copyWith(fontSize: 16, color: color),
          ),
        ],
      ),
    );
  }
}
