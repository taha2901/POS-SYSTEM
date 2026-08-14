import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// رأس الصفحة الموحّد: عنوان + وصف على جهة البداية، وأزرار/فلاتر على النهاية.
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions = const <Widget>[],
    this.leading,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (leading != null) ...<Widget>[
          leading!,
          const SizedBox(width: AppSpacing.md),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.pageTitle.copyWith(fontSize: 24),
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 3),
                Text(
                  subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption,
                ),
              ],
            ],
          ),
        ),
        for (final Widget action in actions) ...<Widget>[
          const SizedBox(width: AppSpacing.md),
          action,
        ],
      ],
    );
  }
}

/// زر رجوع دائري بنفس شكل باقي النظام
class BackCircleButton extends StatefulWidget {
  const BackCircleButton({
    super.key,
    required this.onTap,
    this.tooltip = 'رجوع',
  });

  final VoidCallback onTap;
  final String tooltip;

  @override
  State<BackCircleButton> createState() => _BackCircleButtonState();
}

class _BackCircleButtonState extends State<BackCircleButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
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

/// حقل بحث موحّد في كل شاشات القوائم
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hint = 'ابحث…',
    this.width = 280,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hint;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 46,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppText.body.copyWith(fontSize: 13.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppText.body.copyWith(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
          prefixIcon: const Icon(Icons.search_rounded, size: 19),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: 'مسح',
                  icon: const Icon(Icons.close_rounded, size: 17),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
        ),
      ),
    );
  }
}
