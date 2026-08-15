import 'package:flutter/material.dart';

import '../../../core/widgets/app_data_table.dart';
import '../../../theme/app_theme.dart';

/// خلية بأيقونة في مربع ملوّن + سطرين نص — بتتكرر في كل جداول التقارير.
class ReportIconCell extends StatelessWidget {
  const ReportIconCell({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.color = AppColors.accent,
  });

  final IconData icon;
  final String title;

  /// لو null بيتعرض سطر واحد بس.
  final String? subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: AppRadius.smAll,
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: subtitle == null
              ? TableCells.primary(title)
              : TableCells.twoLine(title, subtitle!),
        ),
      ],
    );
  }
}
