import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// أي عنصر إدخال بعنوان صغير فوقه — الشكل الموحّد في كل النماذج.
class LabeledField extends StatelessWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label, style: AppText.label.copyWith(fontSize: 12.5)),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    );
  }
}
