import 'package:flutter/material.dart';

/// اختصار سريع في شاشة الترحيب.
class QuickLink {
  const QuickLink({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;
}
