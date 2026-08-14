import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// زرار صغير جوه خانة المبلغ أو سطر الدفعة (مسح، إزالة…).
class PaymentMiniAction extends StatefulWidget {
  const PaymentMiniAction({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool danger;

  @override
  State<PaymentMiniAction> createState() => _PaymentMiniActionState();
}

class _PaymentMiniActionState extends State<PaymentMiniAction> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final Color color =
        widget.danger ? AppColors.danger : AppColors.textSecondary;

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
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _hovered
                  ? color.withValues(alpha: 0.10)
                  : Colors.transparent,
              borderRadius: AppRadius.smAll,
            ),
            child: Icon(
              widget.icon,
              size: 17,
              color: _hovered ? color : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
