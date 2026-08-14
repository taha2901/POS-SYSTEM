import 'package:flutter/material.dart';

/// أنيميشن دخول متدرّج (Fade + Slide up خفيف) — كل عنصر بيبدأ بعد اللي قبله.
///
/// القيم الافتراضية هي المستخدمة في لوحة التحكم؛ شاشات تانية بتظبّطها.
class StaggeredReveal extends StatelessWidget {
  const StaggeredReveal({
    super.key,
    required this.controller,
    required this.index,
    required this.child,
    this.step = 0.075,
    this.span = 0.3,
    this.maxStart = 0.7,
    this.slideFrom = 0.14,
  });

  final AnimationController controller;
  final int index;
  final Widget child;

  /// التأخير بين كل عنصر واللي بعده
  final double step;

  /// طول أنيميشن العنصر الواحد
  final double span;

  /// أقصى تأخير مسموح بيه مهما زاد عدد العناصر
  final double maxStart;

  /// مقدار الإزاحة لأسفل في بداية الأنيميشن
  final double slideFrom;

  @override
  Widget build(BuildContext context) {
    final double start = (index * step).clamp(0.0, maxStart);
    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Interval(
        start,
        (start + span).clamp(0.0, 1.0),
        curve: Curves.easeOutCubic,
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, slideFrom),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
