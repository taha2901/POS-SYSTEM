import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/loyalty_controller.dart';
import 'loyalty_tier_card.dart';

/// قسم مستويات العضوية.
class LoyaltyTiersSection extends StatelessWidget {
  const LoyaltyTiersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final LoyaltyController loyalty = context.read<LoyaltyController>();
    final List<LoyaltyTierInfo> tiers = MockData.loyaltyTiers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('مستويات العضوية', style: AppText.sectionTitle),
            const SizedBox(width: AppSpacing.md),
            Text(
              'العميل بيترقّى تلقائيًا لما يوصل للحد الأدنى من النقاط',
              style: AppText.caption,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < tiers.length; i++) ...<Widget>[
                Expanded(
                  child: LoyaltyTierCard(
                    tier: tiers[i],
                    membersCount: loyalty.membersCountFor(tiers[i]),
                  ),
                ),
                if (i != tiers.length - 1) const SizedBox(width: AppSpacing.lg),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
