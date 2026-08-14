import 'package:flutter/material.dart';

/// غلاف بيخفي محتوى خلية الإجراءات لحد ما الماوس يقف على الصف.
class HoverRowAction extends StatelessWidget {
  const HoverRowAction({
    super.key,
    required this.hovered,
    required this.child,
  });

  final bool hovered;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: hovered ? 1 : 0,
      duration: const Duration(milliseconds: 150),
      child: IgnorePointer(
        ignoring: !hovered,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: child,
        ),
      ),
    );
  }
}
