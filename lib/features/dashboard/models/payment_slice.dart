import 'package:flutter/material.dart';

/// شريحة في رسم توزيع طرق الدفع.
class PaymentSlice {
  const PaymentSlice({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final double value;
  final Color color;
  final IconData icon;
}
