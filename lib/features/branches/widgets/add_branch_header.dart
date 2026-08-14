import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// هيدر حوار إضافة فرع.
class AddBranchHeader extends StatelessWidget {
  const AddBranchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: AppRadius.mdAll,
          ),
          child: const Icon(
            Icons.add_business_outlined,
            size: 20,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Text('فرع جديد', style: AppText.sectionTitle)),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded, size: 20),
        ),
      ],
    );
  }
}
