import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// بطاقة الإضافة السريعة في آخر الشبكة.
class AddBranchCard extends StatefulWidget {
  const AddBranchCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<AddBranchCard> createState() => _AddBranchCardState();
}

class _AddBranchCardState extends State<AddBranchCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accentSoft : AppColors.surfaceAlt,
            borderRadius: AppRadius.lgAll,
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.accent
                      : AppColors.accent.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 26,
                  color: _hovered ? Colors.white : AppColors.accent,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('إضافة فرع جديد', style: AppText.cardTitle),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'وسّع نشاطك بفرع إضافي',
                style: AppText.caption.copyWith(fontSize: 11.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
