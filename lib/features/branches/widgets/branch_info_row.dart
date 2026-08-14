import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// سطر معلومة في بطاقة الفرع (عنوان، مواعيد، مسؤول…).
class BranchInfoRow extends StatelessWidget {
  const BranchInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 14, color: AppColors.textMuted),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
