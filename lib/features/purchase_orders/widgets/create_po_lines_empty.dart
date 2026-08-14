import 'package:flutter/material.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../theme/app_theme.dart';
import 'create_po_lines_toolbar.dart';

/// الحالة الفاضية لجدول أصناف الأمر.
class CreatePoLinesEmpty extends StatelessWidget {
  const CreatePoLinesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
              Icons.add_shopping_cart_rounded,
              size: 30,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('لم تتم إضافة أصناف بعد', style: AppText.cardTitle),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'ابحث عن منتج بالضغط على «إضافة صنف»، أو أضف كتالوج المورد كله',
            style: AppText.caption,
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'إضافة أول صنف',
            icon: Icons.add_rounded,
            onPressed: () => pickProductForOrder(context),
          ),
        ],
      ),
    );
  }
}
