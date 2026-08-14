import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'secondary_button.dart';

/// حالة «العنصر غير موجود» في شاشات الملفات.
class NotFoundState extends StatelessWidget {
  const NotFoundState({
    super.key,
    required this.icon,
    required this.message,
    required this.onBack,
    this.backLabel = 'رجوع للقائمة',
  });

  final IconData icon;
  final String message;
  final VoidCallback onBack;
  final String backLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 44, color: AppColors.textMuted),
          const SizedBox(height: AppSpacing.lg),
          Text(message, style: AppText.cardTitle),
          const SizedBox(height: AppSpacing.xl),
          SecondaryButton(label: backLabel, onPressed: onBack),
        ],
      ),
    );
  }
}
