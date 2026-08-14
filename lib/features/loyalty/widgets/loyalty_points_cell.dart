import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// خلية رصيد النقاط بنجمة صفرا.
class LoyaltyPointsCell extends StatelessWidget {
  const LoyaltyPointsCell({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.stars_rounded, size: 15, color: AppColors.warning),
        const SizedBox(width: 5),
        Text(
          Fmt.count(points),
          style: AppText.amountMd.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
