import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// الحالة الفارغة لما مفيش منتجات مطابقة للبحث أو الفئة.
class ProductsEmptyState extends StatelessWidget {
  const ProductsEmptyState({super.key});

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
                Icons.search_off_rounded,
                size: 32,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('لا توجد منتجات مطابقة', style: AppText.cardTitle),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'جرّب كلمة بحث مختلفة أو اختر فئة أخرى',
              style: AppText.caption,
            ),
          ],
        ),
      ),
    );
  }
}
