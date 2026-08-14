import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'return_lines_card.dart';
import 'returns_side_panel.dart';

/// عرض الفاتورة: جدول الأصناف + اللوحة الجانبية.
class ReturnsInvoiceView extends StatelessWidget {
  const ReturnsInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex: 3, child: ReturnLinesCard()),
        SizedBox(width: AppSpacing.xl),
        SizedBox(width: 380, child: ReturnsSidePanel()),
      ],
    );
  }
}
