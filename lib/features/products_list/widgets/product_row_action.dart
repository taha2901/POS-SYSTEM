import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// زرار إجراء صغير جوه صف الجدول (تعديل / حذف).
class ProductRowAction extends StatefulWidget {
  const ProductRowAction({
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
  State<ProductRowAction> createState() => _ProductRowActionState();
}

class _ProductRowActionState extends State<ProductRowAction> {
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
                  : AppColors.surfaceAlt,
              borderRadius: AppRadius.smAll,
              border: Border.all(
                color: _hovered
                    ? color.withValues(alpha: 0.3)
                    : AppColors.border,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 16,
              color: _hovered ? color : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
