import 'package:flutter/material.dart';

import '../../../core/widgets/progress_track.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// صف منتج في بطاقة أفضل المنتجات.
class TopProductRow extends StatelessWidget {
  const TopProductRow({
    super.key,
    required this.stat,
    required this.maxRevenue,
  });

  final ProductSalesStat stat;

  /// إيراد أعلى منتج — الأساس اللي بيتقاس عليه طول الشريط.
  final double maxRevenue;

  @override
  Widget build(BuildContext context) {
    final Product p = stat.product;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  p.accentColor.withValues(alpha: 0.22),
                  p.accentColor.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: AppRadius.mdAll,
            ),
            child: Icon(p.categoryIcon, size: 20, color: p.accentColor),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        p.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.bodyMedium.copyWith(fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      Fmt.moneyRounded(stat.revenue),
                      style: AppText.amountSm.copyWith(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ProgressTrack(
                        ratio: stat.revenue / maxRevenue,
                        gradient: LinearGradient(
                          colors: <Color>[
                            p.accentColor,
                            p.accentColor.withValues(alpha: 0.55),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${Fmt.count(stat.units)} وحدة',
                      style: AppText.caption.copyWith(fontSize: 10.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
