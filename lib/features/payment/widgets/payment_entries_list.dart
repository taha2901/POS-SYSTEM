import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/payment_controller.dart';
import '../models/payment_entry.dart';
import 'payment_entry_row.dart';

/// قايمة الدفعات المسجّلة — بتختفي خالص لو مفيش دفعات.
class PaymentEntriesList extends StatelessWidget {
  const PaymentEntriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController payment = context.watch<PaymentController>();
    final List<PaymentEntry> entries = payment.entries;

    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: AppSpacing.xl),
        Text('الدفعات المسجّلة', style: AppText.label.copyWith(fontSize: 12.5)),
        const SizedBox(height: AppSpacing.md),
        for (int i = 0; i < entries.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: PaymentEntryRow(
              entry: entries[i],
              onRemove: () => payment.removeEntry(i),
            ),
          ),
      ],
    );
  }
}
