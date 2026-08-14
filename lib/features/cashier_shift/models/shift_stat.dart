import 'package:flutter/material.dart';

/// إحصائية صغيرة في أعلى حوار إغلاق الوردية.
class ShiftStat {
  const ShiftStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final double value;
  final IconData icon;
  final Color color;
}
