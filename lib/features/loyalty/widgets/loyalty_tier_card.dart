import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import 'loyalty_tier_benefits.dart';
import 'loyalty_tier_card_header.dart';

/// بطاقة مستوى عضوية واحد.
class LoyaltyTierCard extends StatefulWidget {
  const LoyaltyTierCard({
    super.key,
    required this.tier,
    required this.membersCount,
  });

  final LoyaltyTierInfo tier;
  final int membersCount;

  @override
  State<LoyaltyTierCard> createState() => _LoyaltyTierCardState();
}

class _LoyaltyTierCardState extends State<LoyaltyTierCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final LoyaltyTierInfo tier = widget.tier;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: AppRadius.lgAll,
          boxShadow: _hovered
              ? <BoxShadow>[
                  BoxShadow(
                    color: tier.gradient.first.withValues(alpha: 0.32),
                    blurRadius: 26,
                    offset: const Offset(0, 10),
                  ),
                ]
              : AppShadows.soft,
        ),
        child: ClipRRect(
          borderRadius: AppRadius.lgAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LoyaltyTierCardHeader(
                tier: tier,
                membersCount: widget.membersCount,
              ),
              Expanded(child: LoyaltyTierBenefits(tier: tier)),
            ],
          ),
        ),
      ),
    );
  }
}
