import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AppDropdownItem<T> {
  const AppDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.trailing,
  });

  final T value;
  final String label;
  final IconData? icon;
  final String? trailing;
}

/// قائمة منسدلة موحّدة الشكل — مبنية على PopupMenu عشان نتحكم في التصميم
/// بالكامل (الـDropdownButton الافتراضي شكله مش متناسق مع باقي النظام).
class AppDropdown<T> extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.icon,
    this.hint,
    this.width,
    this.height = 46,
  });

  final T value;
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T> onChanged;
  final IconData? icon;
  final String? hint;
  final double? width;
  final double height;

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  bool _hovered = false;

  AppDropdownItem<T>? get _selected {
    for (final AppDropdownItem<T> item in widget.items) {
      if (item.value == widget.value) return item;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final AppDropdownItem<T>? selected = _selected;

    return PopupMenuButton<T>(
      tooltip: widget.hint ?? '',
      offset: Offset(0, widget.height + 4),
      onSelected: widget.onChanged,
      constraints: BoxConstraints(minWidth: widget.width ?? 220),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<T>>[
        for (final AppDropdownItem<T> item in widget.items)
          PopupMenuItem<T>(
            value: item.value,
            height: 46,
            child: Row(
              children: <Widget>[
                if (item.icon != null) ...<Widget>[
                  Icon(
                    item.icon,
                    size: 17,
                    color: item.value == widget.value
                        ? AppColors.accent
                        : AppColors.textMuted,
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                Expanded(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bodyMedium.copyWith(
                      fontSize: 13.5,
                      color: item.value == widget.value
                          ? AppColors.accent
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                if (item.trailing != null) ...<Widget>[
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    item.trailing!,
                    style: AppText.caption.copyWith(fontSize: 11.5),
                  ),
                ],
              ],
            ),
          ),
      ],
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md + 2),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.mdAll,
            border: Border.all(
              color: _hovered ? AppColors.borderStrong : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize:
                widget.width == null ? MainAxisSize.min : MainAxisSize.max,
            children: <Widget>[
              Icon(
                widget.icon ?? selected?.icon ?? Icons.filter_list_rounded,
                size: 17,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: Text(
                  selected?.label ?? widget.hint ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyMedium.copyWith(fontSize: 13.5),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
