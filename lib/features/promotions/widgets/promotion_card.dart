import 'package:flutter/material.dart';

import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../models/promotion_status_tone.dart';
import '../models/promotion_type_color.dart';
import 'promotion_date_range_row.dart';
import 'promotion_duration_bar.dart';
import 'promotion_type_badge.dart';
import 'promotion_value_row.dart';

/// بطاقة عرض واحد في الشبكة.
class PromotionCard extends StatefulWidget {
  const PromotionCard({super.key, required this.promotion});

  final Promotion promotion;

  @override
  State<PromotionCard> createState() => _PromotionCardState();
}

class _PromotionCardState extends State<PromotionCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final Promotion p = widget.promotion;
    final bool expired = p.status == PromotionStatus.expired;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(
            color: _hovered
                ? p.type.color.withValues(alpha: 0.45)
                : AppColors.border,
          ),
          boxShadow: _hovered ? AppShadows.lifted : AppShadows.soft,
        ),
        child: Opacity(
          opacity: expired ? 0.72 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  PromotionTypeBadge(type: p.type),
                  const Spacer(),
                  StatusBadge(
                    label: p.status.label,
                    tone: p.status.tone,
                    compact: true,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                p.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.cardTitle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                p.scope,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.caption.copyWith(fontSize: 12),
              ),
              const Spacer(),
              PromotionValueRow(promotion: p),
              const SizedBox(height: AppSpacing.md),
              PromotionDurationBar(promotion: p),
              const SizedBox(height: AppSpacing.sm),
              PromotionDateRangeRow(promotion: p),
            ],
          ),
        ),
      ),
    );
  }
}
