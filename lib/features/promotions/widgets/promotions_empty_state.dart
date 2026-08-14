import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// الحالة الفاضية لما مفيش عروض مطابقة للفلتر.
class PromotionsEmptyState extends StatelessWidget {
  const PromotionsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.surfaceAlt,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_offer_outlined,
                size: 30,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('لا توجد عروض بهذا الفلتر', style: AppText.cardTitle),
          ],
        ),
      ),
    );
  }
}
