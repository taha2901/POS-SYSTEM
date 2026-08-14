import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// زر مسح الباركود المربّع جنب شريط البحث.
class PosScannerButton extends StatefulWidget {
  const PosScannerButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<PosScannerButton> createState() => _PosScannerButtonState();
}

class _PosScannerButtonState extends State<PosScannerButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'مسح الباركود',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: _hovered ? AppColors.accentDark : AppColors.accent,
              borderRadius: AppRadius.lgAll,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.accent.withValues(
                    alpha: _hovered ? 0.38 : 0.24,
                  ),
                  blurRadius: _hovered ? 20 : 12,
                  offset: Offset(0, _hovered ? 7 : 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              size: 26,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
