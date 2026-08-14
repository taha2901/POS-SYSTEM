import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';

/// لون ثابت لكل فئة مصروف — بيتوزّع بالترتيب على الـpalette.
Color expenseCategoryColor(String category) {
  const List<Color> palette = <Color>[
    Color(0xFF6366F1),
    Color(0xFF0EA5E9),
    Color(0xFFF59E0B),
    Color(0xFF10B981),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFF14B8A6),
    Color(0xFF64748B),
  ];

  final int index = MockData.expenseCategories.indexOf(category);
  return palette[(index < 0 ? 0 : index) % palette.length];
}
