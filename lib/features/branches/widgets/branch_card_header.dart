import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// رأس بطاقة الفرع: الأيقونة والاسم وحالة الفتح.
class BranchCardHeader extends StatelessWidget {
  const BranchCardHeader({super.key, required this.branch});

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    final Branch b = branch;

    return Row(
      children: <Widget>[
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: b.isMain
                  ? <Color>[AppColors.accent, const Color(0xFF8B5CF6)]
                  : <Color>[AppColors.primaryLight, AppColors.primary],
            ),
            borderRadius: AppRadius.mdAll,
          ),
          child: Icon(
            b.isMain ? Icons.star_rounded : Icons.storefront_rounded,
            size: 23,
            color: Colors.white,
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
                  // النقطة الملونة: أخضر = مفتوح، رمادي = مغلق
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: b.isOpen
                          ? AppColors.success
                          : AppColors.textMuted,
                      shape: BoxShape.circle,
                      boxShadow: b.isOpen
                          ? <BoxShadow>[
                              BoxShadow(
                                color: AppColors.success
                                    .withValues(alpha: 0.4),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      b.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.cardTitle.copyWith(fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                b.isOpen ? 'مفتوح الآن' : 'مغلق',
                style: AppText.caption.copyWith(
                  fontSize: 11.5,
                  color:
                      b.isOpen ? AppColors.success : AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
