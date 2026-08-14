import 'package:flutter/material.dart';

import 'hover_row_action.dart';
import 'primary_button.dart';

/// زرار صغير في آخر صف الجدول — بيظهر عند الـHover على الصف بس.
class HoverRowButton extends StatelessWidget {
  const HoverRowButton({
    super.key,
    required this.label,
    required this.hovered,
    required this.onPressed,
    this.color,
  });

  final String label;
  final bool hovered;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return HoverRowAction(
      hovered: hovered,
      child: PrimaryButton(
        label: label,
        size: AppButtonSize.small,
        color: color,
        onPressed: onPressed,
      ),
    );
  }
}
