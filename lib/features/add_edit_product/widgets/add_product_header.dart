import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_theme.dart';
import 'add_product_back_button.dart';

/// هيدر الشاشة: زرار الرجوع + العنوان والوصف.
class AddProductHeader extends StatelessWidget {
  const AddProductHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AddProductBackButton(onTap: () => context.go('/products')),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'إضافة منتج جديد',
                style: AppText.pageTitle.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 3),
              Text(
                'املأ البيانات في التبويبات التالية ثم اضغط «حفظ المنتج»',
                style: AppText.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
