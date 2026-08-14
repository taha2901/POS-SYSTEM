import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// رأس جدول الأصناف المحوّلة.
class TransferLinesHeader extends StatelessWidget {
  const TransferLinesHeader({super.key});

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
          Expanded(flex: 2, child: Text('المتاح بالفرع', style: AppText.label)),
          SizedBox(
            width: 140,
            child: Text('الكمية المحوّلة', style: AppText.label),
          ),
          Expanded(flex: 2, child: Text('القيمة', style: AppText.label)),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
