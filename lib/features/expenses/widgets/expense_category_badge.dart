import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../models/expense_category_color.dart';

/// شارة فئة المصروف بلونها الثابت.
class ExpenseCategoryBadge extends StatelessWidget {
  const ExpenseCategoryBadge({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final Color color = expenseCategoryColor(category);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md - 2,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
