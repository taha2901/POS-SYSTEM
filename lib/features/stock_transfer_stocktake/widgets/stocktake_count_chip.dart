import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// شارة عدّاد صغيرة في شريط أدوات الجرد.
class StocktakeCountChip extends StatelessWidget {
  const StocktakeCountChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md + 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 15, color: color),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: AppText.caption.copyWith(fontSize: 12)),
          const SizedBox(width: 6),
          Text(
            value,
            style: AppText.amountSm.copyWith(fontSize: 13, color: color),
          ),
        ],
      ),
    );
  }
}
