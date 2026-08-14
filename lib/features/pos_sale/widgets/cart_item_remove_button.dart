import 'package:flutter/material.dart';

/// أيقونة حذف الصنف من السلة.
class CartItemRemoveButton extends StatelessWidget {
  const CartItemRemoveButton({
    super.key,
    required this.color,
    required this.onTap,
  });

  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'حذف الصنف',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 22,
            height: 22,
            child: Icon(Icons.close_rounded, size: 16, color: color),
          ),
        ),
      ),
    );
  }
}
