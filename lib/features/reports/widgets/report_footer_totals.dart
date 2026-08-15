import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// فوتر الجدول: مجاميع مفصولة بخطوط رأسية.
class ReportFooterTotals extends StatelessWidget {
  const ReportFooterTotals({super.key, required this.totals});

  /// كل عنصر = (العنوان، القيمة)
  final List<(String, String)> totals;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < totals.length; i++) ...<Widget>[
          if (i > 0)
            Container(
              width: 1,
              height: 22,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              color: AppColors.border,
            ),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  totals[i].$1,
                  style: AppText.caption.copyWith(fontSize: 12),
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    totals[i].$2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.amountSm.copyWith(fontSize: 13.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
