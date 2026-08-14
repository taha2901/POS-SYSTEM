import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// مبيعات اليوم أسفل بطاقة الفرع.
class BranchTodaySales extends StatelessWidget {
  const BranchTodaySales({super.key, required this.sales, this.muted = false});

  final double sales;

  /// الفروع قيد التجهيز بتتعرض بلون باهت.
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('مبيعات اليوم', style: AppText.label.copyWith(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          muted ? Fmt.money(sales) : Fmt.moneyRounded(sales),
          style: AppText.amountHero.copyWith(
            fontSize: 24,
            color: muted ? AppColors.textMuted : null,
          ),
        ),
      ],
    );
  }
}
