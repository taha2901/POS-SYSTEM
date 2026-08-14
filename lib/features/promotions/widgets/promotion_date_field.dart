import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// حقل اختيار تاريخ بشكل زرار.
class PromotionDateField extends StatefulWidget {
  const PromotionDateField({
    super.key,
    required this.label,
    required this.date,
    required this.onTap,
  });

  final String label;
  final DateTime date;
  final VoidCallback onTap;

  @override
  State<PromotionDateField> createState() => _PromotionDateFieldState();
}

class _PromotionDateFieldState extends State<PromotionDateField> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(widget.label, style: AppText.label.copyWith(fontSize: 12.5)),
        const SizedBox(height: AppSpacing.sm),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.mdAll,
                border: Border.all(
                  color: _hovered ? AppColors.accent : AppColors.border,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 16,
                    color: _hovered ? AppColors.accent : AppColors.textMuted,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      Fmt.date(widget.date),
                      style: AppText.amountSm.copyWith(fontSize: 13.5),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
