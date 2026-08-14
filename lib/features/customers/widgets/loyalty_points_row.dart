import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// سطر في بطاقة النقاط (مكتسبة / مستبدلة).
class LoyaltyPointsRow extends StatelessWidget {
  const LoyaltyPointsRow({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textOnDarkMuted,
            ),
          ),
        ),
        Text(
          Fmt.count(value),
          style: AppText.amountSm.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
