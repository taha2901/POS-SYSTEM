import 'package:flutter/material.dart';

import '../../../core/widgets/account_timeline.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import 'supplier_ledger_chip.dart';

/// التبويب التاني: كشف الحساب والمدفوعات.
class SupplierLedgerTab extends StatelessWidget {
  const SupplierLedgerTab({super.key, required this.supplier});

  final Supplier supplier;

  @override
  Widget build(BuildContext context) {
    final List<LedgerEntry> entries = MockData.ledgerFor(supplier.id);
    final double paid = entries
        .where((LedgerEntry e) => !e.isDebit)
        .fold<double>(0, (double sum, LedgerEntry e) => sum + e.amount.abs());

    return Container(
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.lg,
            ),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'كشف الحساب والمدفوعات',
                      style: AppText.sectionTitle,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${Fmt.count(entries.length)} حركة مالية',
                      style: AppText.caption,
                    ),
                  ],
                ),
                const Spacer(),
                SupplierLedgerChip(
                  label: 'إجمالي المدفوع',
                  value: Fmt.money(paid),
                  color: AppColors.success,
                ),
                const SizedBox(width: AppSpacing.md),
                SupplierLedgerChip(
                  label: 'المستحق للمورد',
                  value: Fmt.money(supplier.balanceDue),
                  color: supplier.balanceDue > 0
                      ? AppColors.danger
                      : AppColors.success,
                ),
              ],
            ),
          ),
          Expanded(
            child: AccountTimeline(
              entries: entries,
              debitLabel: 'مستحق',
              creditLabel: 'مدفوع',
              emptyMessage: 'لا توجد حركات مالية مع هذا المورد',
            ),
          ),
        ],
      ),
    );
  }
}
