import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../models/stocktake_diff_style.dart';
import '../models/stocktake_line.dart';

/// شارة الفرق بين الكمية الفعلية والنظام.
class StocktakeDiffBadge extends StatelessWidget {
  const StocktakeDiffBadge({
    super.key,
    required this.line,
    required this.style,
  });

  final StocktakeLine line;
  final StocktakeDiffStyle style;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: style.color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(style.icon, size: 14, color: style.color),
          const SizedBox(width: 5),
          Text(
            line.isCounted
                ? '${line.difference > 0 ? '+' : ''}'
                    '${Fmt.count(line.difference)}'
                : style.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: style.color,
            ),
          ),
        ],
      ),
    );
  }
}
