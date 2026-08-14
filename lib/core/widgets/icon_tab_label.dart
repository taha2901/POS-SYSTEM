import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// محتوى تبويب بأيقونة وعنوان — بيستخدم في شاشات الملفات (عميل/مورد).
class IconTabLabel extends StatelessWidget {
  const IconTabLabel({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16),
          const SizedBox(width: AppSpacing.sm),
          Text(label),
        ],
      ),
    );
  }
}
