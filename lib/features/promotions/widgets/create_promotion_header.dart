import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// هيدر حوار إنشاء العرض.
class CreatePromotionHeader extends StatelessWidget {
  const CreatePromotionHeader({super.key});

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
            Icons.local_offer_outlined,
            size: 20,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Text('عرض جديد', style: AppText.sectionTitle)),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded, size: 20),
        ),
      ],
    );
  }
}
