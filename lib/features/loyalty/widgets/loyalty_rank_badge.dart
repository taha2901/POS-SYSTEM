import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// رقم الترتيب — ميدالية للأوائل الثلاثة.
class LoyaltyRankBadge extends StatelessWidget {
  const LoyaltyRankBadge({super.key, required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    final bool isMedal = rank <= 3;
    final List<Color> gradient = switch (rank) {
      1 => <Color>[const Color(0xFFFBBF24), const Color(0xFFB45309)],
      2 => <Color>[const Color(0xFFCBD5E1), const Color(0xFF64748B)],
      3 => <Color>[const Color(0xFFD97706), const Color(0xFF92400E)],
      _ => <Color>[AppColors.surfaceAlt, AppColors.surfaceAlt],
    };

    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: gradient,
        ),
        shape: BoxShape.circle,
        border: isMedal ? null : Border.all(color: AppColors.border),
      ),
      child: isMedal
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.emoji_events_rounded,
                  size: 15,
                  color: Colors.white,
                ),
                Text(
                  '$rank',
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
              ],
            )
          : Text(
              '$rank',
              style: AppText.amountSm.copyWith(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
    );
  }
}
