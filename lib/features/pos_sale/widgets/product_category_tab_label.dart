import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// محتوى تبويب الفئة: أيقونة + اسم + عدد المنتجات.
class ProductCategoryTabLabel extends StatelessWidget {
  const ProductCategoryTabLabel({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
  });

  final IconData icon;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 17),
          const SizedBox(width: AppSpacing.sm),
          Text(label),
          const SizedBox(width: 6),
          Text(
            '($count)',
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
