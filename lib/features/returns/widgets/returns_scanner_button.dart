import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../models/return_accent.dart';

/// زرار مسح باركود الفاتورة.
class ReturnsScannerButton extends StatefulWidget {
  const ReturnsScannerButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<ReturnsScannerButton> createState() => _ReturnsScannerButtonState();
}

class _ReturnsScannerButtonState extends State<ReturnsScannerButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'مسح باركود الفاتورة',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: _hovered ? kReturnAccentDark : kReturnAccent,
              borderRadius: AppRadius.lgAll,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kReturnAccent.withValues(
                    alpha: _hovered ? 0.38 : 0.24,
                  ),
                  blurRadius: _hovered ? 20 : 12,
                  offset: Offset(0, _hovered ? 7 : 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              size: 27,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
