import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// بطاقة اختصار سريع في شاشة الترحيب.
class QuickLinkCard extends StatefulWidget {
  const QuickLinkCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<QuickLinkCard> createState() => _QuickLinkCardState();
}

class _QuickLinkCardState extends State<QuickLinkCard> {
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
          curve: Curves.easeOut,
          width: 148,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lgAll,
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.45)
                  : AppColors.border,
            ),
            boxShadow: _hovered ? AppShadows.lifted : AppShadows.soft,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.accent
                      : AppColors.accent.withValues(alpha: 0.10),
                  borderRadius: AppRadius.mdAll,
                ),
                child: Icon(
                  widget.icon,
                  size: 22,
                  color: _hovered ? Colors.white : AppColors.accent,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: AppText.cardTitle.copyWith(fontSize: 13.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
