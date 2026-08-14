import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// رأس جدول أصناف الأمر.
class CreatePoLinesHeader extends StatelessWidget {
  const CreatePoLinesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceAlt,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(flex: 4, child: Text('المنتج', style: AppText.label)),
          Expanded(flex: 2, child: Text('المخزون الحالي', style: AppText.label)),
          SizedBox(
            width: 120,
            child: Text(
              'الكمية',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              'سعر الشراء',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              'الإجمالي',
              style: AppText.label,
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}
