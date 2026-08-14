import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// رأس جدول أصناف الاستلام.
class ReceiveLinesHeader extends StatelessWidget {
  const ReceiveLinesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      color: AppColors.surfaceAlt,
      child: Row(
        children: <Widget>[
          Expanded(flex: 4, child: Text('المنتج', style: AppText.label)),
          SizedBox(
            width: 90,
            child: Text(
              'المطلوب',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'مستلم سابقًا',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              'الكمية المستلمة',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              'المتبقي',
              style: AppText.label,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
