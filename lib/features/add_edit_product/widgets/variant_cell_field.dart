import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/app_theme.dart';

/// خانة إدخال صغيرة جوه صف المتغيرات.
class VariantCellField extends StatelessWidget {
  const VariantCellField({
    super.key,
    required this.hint,
    required this.initial,
    required this.onChanged,
    this.numeric = false,
  });

  final String hint;
  final String initial;
  final ValueChanged<String> onChanged;
  final bool numeric;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        initialValue: initial,
        onChanged: onChanged,
        keyboardType: numeric ? TextInputType.number : null,
        inputFormatters: numeric
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        style: AppText.body.copyWith(fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppText.caption.copyWith(fontSize: 12),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
      ),
    );
  }
}
