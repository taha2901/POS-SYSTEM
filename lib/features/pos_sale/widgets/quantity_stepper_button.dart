import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// زر دائري صغير (+ / −) داخل عدّاد الكمية.
class QuantityStepperButton extends StatefulWidget {
  const QuantityStepperButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.accent = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final bool accent;

  @override
  State<QuantityStepperButton> createState() => _QuantityStepperButtonState();
}

class _QuantityStepperButtonState extends State<QuantityStepperButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final Color bg = widget.accent
        ? (_hovered ? AppColors.accentDark : AppColors.accent)
        : (_hovered ? AppColors.borderStrong : AppColors.surface);
    final Color fg = widget.accent
        ? Colors.white
        : (_hovered ? AppColors.textPrimary : AppColors.textSecondary);

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 130),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
              border: widget.accent
                  ? null
                  : Border.all(color: AppColors.border),
            ),
            child: Icon(widget.icon, size: 15, color: fg),
          ),
        ),
      ),
    );
  }
}
