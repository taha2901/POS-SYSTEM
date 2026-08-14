import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import 'loyalty_balance_card.dart';
import 'loyalty_history_table.dart';

/// التبويب التالت: نقاط الولاء — بطاقة الرصيد + سجل الحركات.
class CustomerLoyaltyTab extends StatelessWidget {
  const CustomerLoyaltyTab({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    final List<LoyaltyEntry> entries = MockData.loyaltyFor(customer.id);

    final int earned = entries
        .where((LoyaltyEntry e) => e.type == LoyaltyType.earn)
        .fold<int>(0, (int s, LoyaltyEntry e) => s + e.points);
    final int redeemed = entries
        .where((LoyaltyEntry e) => e.type == LoyaltyType.redeem)
        .fold<int>(0, (int s, LoyaltyEntry e) => s + e.points.abs());

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 300,
          child: LoyaltyBalanceCard(
            customer: customer,
            earned: earned,
            redeemed: redeemed,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(child: LoyaltyHistoryTable(entries: entries)),
      ],
    );
  }
}
