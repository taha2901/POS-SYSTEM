import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// فترة العرض بنص صغير رمادي أسفل البطاقة.
class PromotionDateRangeRow extends StatelessWidget {
  const PromotionDateRangeRow({super.key, required this.promotion});

  final Promotion promotion;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(
          Icons.event_outlined,
          size: 13,
          color: AppColors.textMuted,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            '${Fmt.date(promotion.startDate)}  ←  '
            '${Fmt.date(promotion.endDate)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption.copyWith(fontSize: 11.5),
          ),
        ),
      ],
    );
  }
}
