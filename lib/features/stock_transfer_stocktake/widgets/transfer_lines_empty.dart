import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// الحالة الفاضية لجدول الأصناف.
class TransferLinesEmpty extends StatelessWidget {
  const TransferLinesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Column(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.surfaceAlt,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              size: 24,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('لم تتم إضافة أصناف بعد', style: AppText.cardTitle),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'اضغط «إضافة صنف» لاختيار المنتجات المراد تحويلها',
            style: AppText.caption,
          ),
        ],
      ),
    );
  }
}
