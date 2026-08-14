import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// رأس جدول الجرد.
class StocktakeTableHeader extends StatelessWidget {
  const StocktakeTableHeader({super.key});

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
          Expanded(flex: 2, child: Text('الفئة', style: AppText.label)),
          SizedBox(
            width: 130,
            child: Text(
              'الكمية بالنظام',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              'الكمية الفعلية',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              'الفرق',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
