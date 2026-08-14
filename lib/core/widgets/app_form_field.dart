import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_theme.dart';

/// حقل إدخال بعنوان فوقه — الشكل الموحّد لكل النماذج في النظام.
class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.helper,
    this.suffixText,
    this.prefixIcon,
    this.maxLines = 1,
    this.required = false,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final Widget? helper;
  final String? suffixText;
  final IconData? prefixIcon;
  final int maxLines;
  final bool required;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(label, style: AppText.label.copyWith(fontSize: 12.5)),
            if (required) ...<Widget>[
              const SizedBox(width: 3),
              const Text(
                '*',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.danger,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          style: AppText.body.copyWith(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            suffixText: suffixText,
            suffixStyle: AppText.caption.copyWith(fontSize: 12),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 18)
                : null,
            fillColor: enabled ? AppColors.surface : AppColors.surfaceAlt,
          ),
        ),
        if (helper != null) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          helper!,
        ],
      ],
    );
  }
}

/// عنوان قسم داخل نموذج طويل
class FormSectionTitle extends StatelessWidget {
  const FormSectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: AppRadius.smAll,
            ),
            child: Icon(icon, size: 17, color: AppColors.accent),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: AppText.cardTitle.copyWith(fontSize: 15)),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 2),
                Text(subtitle!, style: AppText.caption.copyWith(fontSize: 12)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
