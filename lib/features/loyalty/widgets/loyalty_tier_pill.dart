import 'package:flutter/material.dart';

import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// شارة مستوى العميل في جدول الترتيب.
class LoyaltyTierPill extends StatelessWidget {
  const LoyaltyTierPill({super.key, required this.tier});

  /// null = العميل لسه ماوصلش لأي مستوى
  final LoyaltyTierInfo? tier;

  @override
  Widget build(BuildContext context) {
    if (tier == null) {
      return const StatusBadge(
        label: 'بدون مستوى',
        tone: StatusTone.neutral,
        showDot: false,
        compact: true,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md - 2,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: tier!.gradient),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(tier!.icon, size: 12, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            tier!.name,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
