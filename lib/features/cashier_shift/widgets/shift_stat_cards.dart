import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/shift_controller.dart';
import '../models/shift_stat.dart';
import 'shift_mini_stat_card.dart';

/// صف بطاقات إحصائيات الوردية.
class ShiftStatCards extends StatelessWidget {
  const ShiftStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ShiftStat> stats = context.read<ShiftController>().stats;

    return Row(
      children: <Widget>[
        for (int i = 0; i < stats.length; i++) ...<Widget>[
          Expanded(child: ShiftMiniStatCard(stat: stats[i])),
          if (i != stats.length - 1) const SizedBox(width: AppSpacing.md),
        ],
      ],
    );
  }
}
