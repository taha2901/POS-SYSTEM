import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

enum AppButtonSize { small, medium, large, hero }

/// الزر الأساسي — بلون الـAccent، يُستخدم للإجراء الأهم في الشاشة فقط.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.size = AppButtonSize.medium,
    this.expanded = false,
    this.isLoading = false,
    this.color,
    this.trailing,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonSize size;
  final bool expanded;
  final bool isLoading;

  /// لتجاوز لون الـAccent (مثلاً أحمر لزر حذف مؤكَّد)
  final Color? color;
  final Widget? trailing;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  ({double height, double fontSize, double iconSize, double padding})
      get _metrics => switch (widget.size) {
            AppButtonSize.small => (
                height: 38.0,
                fontSize: 13.0,
                iconSize: 16.0,
                padding: 16.0
              ),
            AppButtonSize.medium => (
                height: 46.0,
                fontSize: 14.0,
                iconSize: 18.0,
                padding: 22.0
              ),
            AppButtonSize.large => (
                height: 54.0,
                fontSize: 15.5,
                iconSize: 20.0,
                padding: 28.0
              ),
            AppButtonSize.hero => (
                height: 64.0,
                fontSize: 18.0,
                iconSize: 24.0,
                padding: 32.0
              ),
          };

  @override
  Widget build(BuildContext context) {
    final ({double height, double fontSize, double iconSize, double padding})
        m = _metrics;
    final Color base = widget.color ?? AppColors.accent;
    final Color background = !_enabled
        ? AppColors.borderStrong
        : _pressed
            ? Color.alphaBlend(Colors.black.withValues(alpha: 0.12), base)
            : _hovered
                ? Color.alphaBlend(Colors.black.withValues(alpha: 0.06), base)
                : base;

    final Widget content = widget.isLoading
        ? SizedBox(
            height: m.iconSize,
            width: m.iconSize,
            child: const CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.icon != null) ...<Widget>[
                Icon(widget.icon, size: m.iconSize, color: Colors.white),
                const SizedBox(width: AppSpacing.sm + 2),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: m.fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
              if (widget.trailing != null) ...<Widget>[
                const SizedBox(width: AppSpacing.sm + 2),
                widget.trailing!,
              ],
            ],
          );

    final Widget button = AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      height: m.height,
      padding: EdgeInsets.symmetric(horizontal: m.padding),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          widget.size == AppButtonSize.hero ? AppRadius.lg : AppRadius.md,
        ),
        boxShadow: _enabled && !_pressed
            ? <BoxShadow>[
                BoxShadow(
                  color: base.withValues(alpha: _hovered ? 0.34 : 0.22),
                  blurRadius: _hovered ? 20 : 12,
                  offset: Offset(0, _hovered ? 7 : 4),
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.labelLarge!,
        child: content,
      ),
    );

    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.label,
      child: MouseRegion(
        cursor: _enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() {
          _hovered = false;
          _pressed = false;
        }),
        child: GestureDetector(
          onTapDown: _enabled ? (_) => setState(() => _pressed = true) : null,
          onTapUp: _enabled ? (_) => setState(() => _pressed = false) : null,
          onTapCancel:
              _enabled ? () => setState(() => _pressed = false) : null,
          onTap: _enabled ? widget.onPressed : null,
          child: widget.expanded
              ? SizedBox(width: double.infinity, child: button)
              : button,
        ),
      ),
    );
  }
}
