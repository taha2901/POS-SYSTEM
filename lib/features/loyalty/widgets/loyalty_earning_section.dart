import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'loyalty_example_card.dart';
import 'loyalty_rate_field.dart';

/// قسم إعداد آلية كسب النقاط.
class LoyaltyEarningSection extends StatelessWidget {
  const LoyaltyEarningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: AppDecorations.card(),
      child: Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              borderRadius: AppRadius.mdAll,
            ),
            child: const Icon(
              Icons.stars_rounded,
              size: 23,
              color: AppColors.warning,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('آلية كسب النقاط', style: AppText.cardTitle),
                const SizedBox(height: 3),
                Text(
                  'حدّد عدد النقاط اللي العميل بيكسبها عن كل جنيه يشتريه',
                  style: AppText.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
          const SizedBox(width: 200, child: LoyaltyRateField()),
          const SizedBox(width: AppSpacing.xl),
          const LoyaltyExampleCard(),
        ],
      ),
    );
  }
}
