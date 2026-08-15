import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// شريحة اختيار فترة في شريط فلاتر التقارير.
class ReportPeriodChip extends StatefulWidget {
  const ReportPeriodChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<ReportPeriodChip> createState() => _ReportPeriodChipState();
}

class _ReportPeriodChipState extends State<ReportPeriodChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool active = widget.selected;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary
                : _hovered
                    ? AppColors.surfaceAlt
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm + 2),
            border: Border.all(
              color: active ? AppColors.primary : AppColors.border,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
