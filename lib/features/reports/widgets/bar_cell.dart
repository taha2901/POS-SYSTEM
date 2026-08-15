import 'package:flutter/material.dart';

import '../../../core/widgets/progress_track.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// خلية فيها المبلغ وتحته شريط نسبي.
class BarCell extends StatelessWidget {
  const BarCell({
    super.key,
    required this.value,
    required this.max,
    this.color = AppColors.accent,
  });

  final double value;
  final double max;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Fmt.money(value),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppText.amountSm.copyWith(fontSize: 13),
        ),
        const SizedBox(height: 5),
        ProgressTrack(
          ratio: max == 0 ? 0 : value / max,
          height: 5,
          color: color,
        ),
      ],
    );
  }
}
