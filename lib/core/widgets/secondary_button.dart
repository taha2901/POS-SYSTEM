import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'primary_button.dart' show AppButtonSize;

/// الزر الثانوي — خلفية بيضاء وحد رمادي رفيع، للإجراءات المساندة.
class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.size = AppButtonSize.medium,
    this.expanded = false,
    this.tone = SecondaryButtonTone.neutral,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonSize size;
  final bool expanded;
  final SecondaryButtonTone tone;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

enum SecondaryButtonTone { neutral, accent, danger, success }

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _hovered = false;

  bool get _enabled => widget.onPressed != null;

  Color get _foreground => switch (widget.tone) {
        SecondaryButtonTone.neutral => AppColors.textPrimary,
        SecondaryButtonTone.accent => AppColors.accent,
        SecondaryButtonTone.danger => AppColors.danger,
        SecondaryButtonTone.success => AppColors.success,
      };

  ({double height, double fontSize, double iconSize, double padding})
      get _metrics => switch (widget.size) {
            AppButtonSize.small => (
                height: 38.0,
                fontSize: 13.0,
                iconSize: 16.0,
                padding: 14.0
              ),
            AppButtonSize.medium => (
                height: 46.0,
                fontSize: 14.0,
                iconSize: 18.0,
                padding: 18.0
              ),
            AppButtonSize.large => (
                height: 54.0,
                fontSize: 15.5,
                iconSize: 20.0,
                padding: 24.0
              ),
            AppButtonSize.hero => (
                height: 64.0,
                fontSize: 17.0,
                iconSize: 22.0,
                padding: 28.0
              ),
          };

  @override
  Widget build(BuildContext context) {
    final ({double height, double fontSize, double iconSize, double padding})
        m = _metrics;
    final Color fg = _enabled ? _foreground : AppColors.textMuted;

    final Widget button = AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      height: m.height,
      padding: EdgeInsets.symmetric(horizontal: m.padding),
      decoration: BoxDecoration(
        color: !_enabled
            ? AppColors.surfaceAlt
            : _hovered
                ? (widget.tone == SecondaryButtonTone.neutral
                    ? AppColors.surfaceAlt
                    : fg.withValues(alpha: 0.06))
                : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _hovered && _enabled && widget.tone != SecondaryButtonTone.neutral
              ? fg.withValues(alpha: 0.35)
              : _hovered && _enabled
                  ? AppColors.borderStrong
                  : AppColors.border,
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.icon != null) ...<Widget>[
            Icon(widget.icon, size: m.iconSize, color: fg),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Text(
              widget.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: m.fontSize,
                fontWeight: FontWeight.w600,
                color: fg,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );

    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.label,
      child: MouseRegion(
        cursor: _enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: widget.expanded
              ? SizedBox(width: double.infinity, child: button)
              : button,
        ),
      ),
    );
  }
}
