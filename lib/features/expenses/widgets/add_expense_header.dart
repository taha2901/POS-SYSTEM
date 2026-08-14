import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// هيدر حوار إضافة مصروف.
class AddExpenseHeader extends StatelessWidget {
  const AddExpenseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.danger.withValues(alpha: 0.10),
            borderRadius: AppRadius.mdAll,
          ),
          child: const Icon(
            Icons.receipt_long_outlined,
            size: 20,
            color: AppColors.danger,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Text('مصروف جديد', style: AppText.sectionTitle)),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded, size: 20),
        ),
      ],
    );
  }
}
