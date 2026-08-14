import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../models/draft_branch.dart';
import 'branch_info_row.dart';
import 'branch_today_sales.dart';

/// بطاقة فرع مضاف حديثًا (بيانات مبدئية).
class DraftBranchCard extends StatelessWidget {
  const DraftBranchCard({super.key, required this.draft});

  final DraftBranch draft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: AppRadius.mdAll,
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  size: 23,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.textMuted,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            draft.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.cardTitle.copyWith(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'قيد التجهيز',
                      style: AppText.caption.copyWith(
                        fontSize: 11.5,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          BranchInfoRow(
            icon: Icons.location_on_outlined,
            text: draft.address,
          ),
          const SizedBox(height: AppSpacing.sm),
          BranchInfoRow(
            icon: Icons.person_outline_rounded,
            text: draft.manager,
          ),
          const Spacer(),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.md),
          const BranchTodaySales(sales: 0, muted: true),
        ],
      ),
    );
  }
}
