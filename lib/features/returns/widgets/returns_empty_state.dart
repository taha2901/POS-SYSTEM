import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../models/return_accent.dart';

/// الحالة الأولى قبل ما يتم اختيار فاتورة.
class ReturnsEmptyState extends StatelessWidget {
  const ReturnsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: kReturnAccent.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.assignment_return_outlined,
                size: 38,
                color: kReturnAccent,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('ابدأ بالبحث عن الفاتورة', style: AppText.pageTitle),
            const SizedBox(height: AppSpacing.sm),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Text(
                'أدخل رقم الفاتورة أو امسح الباركود الموجود عليها، '
                'وهتظهر أصنافها هنا لاختيار المرتجع منها.',
                textAlign: TextAlign.center,
                style: AppText.body.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
