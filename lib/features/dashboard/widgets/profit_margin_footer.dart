import 'package:flutter/material.dart';

import '../../../core/widgets/progress_track.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// شريط هامش الربح أسفل بطاقة صافي الربح.
class ProfitMarginFooter extends StatelessWidget {
  const ProfitMarginFooter({super.key, required this.margin});

  final double margin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ProgressTrack(
            // 50% هامش = شريط ممتلئ
            ratio: margin / 50,
            height: 5,
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'هامش ${Fmt.percent(margin)}',
          style: AppText.caption.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}
