import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// زرار الرجوع لشاشة المنتجات.
class AddProductBackButton extends StatefulWidget {
  const AddProductBackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<AddProductBackButton> createState() => _AddProductBackButtonState();
}

class _AddProductBackButtonState extends State<AddProductBackButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'رجوع للمنتجات',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _hovered ? AppColors.surfaceAlt : AppColors.surface,
              borderRadius: AppRadius.mdAll,
              border: Border.all(
                color: _hovered ? AppColors.borderStrong : AppColors.border,
              ),
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              size: 19,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
