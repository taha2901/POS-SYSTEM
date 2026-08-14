import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'returns_reason_field.dart';
import 'returns_refund_method_field.dart';
import 'returns_summary.dart';

/// اللوحة الجانبية: سبب الإرجاع وطريقة الاسترداد والإجمالي.
class ReturnsSidePanel extends StatelessWidget {
  const ReturnsSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('تفاصيل المرتجع', style: AppText.sectionTitle),
                const SizedBox(height: AppSpacing.xl),
                const ReturnsReasonField(),
                const SizedBox(height: AppSpacing.lg),
                const ReturnsRefundMethodField(),
              ],
            ),
          ),
          const Spacer(),
          const ReturnsSummary(),
        ],
      ),
    );
  }
}
