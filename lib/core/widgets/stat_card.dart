import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/formatters.dart';

/// بطاقة إحصائية: أيقونة + عنوان + رقم كبير + نسبة تغيّر.
class StatCard extends StatefulWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor = AppColors.accent,
    this.changePercent,
    this.changeLabel = 'مقارنة بالشهر الماضي',
    this.higherIsBetter = true,
    this.footer,
    this.onTap,
  });

  final String title;

  /// القيمة كنص جاهز (استخدم Fmt.money / Fmt.count)
  final String value;
  final IconData icon;
  final Color iconColor;

  /// موجب = زيادة، سالب = نقصان. لو null الشريط السفلي مش هيظهر.
  final double? changePercent;
  final String changeLabel;

  /// في بعض المؤشرات (زي المرتجعات) النقصان هو الأحسن.
  final bool higherIsBetter;
  final Widget? footer;
  final VoidCallback? onTap;

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final double? change = widget.changePercent;
    final bool isUp = (change ?? 0) >= 0;
    final bool isGood = widget.higherIsBetter ? isUp : !isUp;
    final Color changeColor = change == null || change == 0
        ? AppColors.textSecondary
        : isGood
            ? AppColors.success
            : AppColors.danger;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lgAll,
            border: Border.all(
              color: _hovered ? AppColors.borderStrong : AppColors.border,
            ),
            boxShadow: _hovered ? AppShadows.lifted : AppShadows.soft,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: widget.iconColor.withValues(alpha: 0.10),
                      borderRadius: AppRadius.mdAll,
                    ),
                    child: Icon(
                      widget.icon,
                      size: 21,
                      color: widget.iconColor,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.label.copyWith(fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(widget.value, style: AppText.amountXl),
              ),
              if (change != null) ...<Widget>[
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: changeColor.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            isUp
                                ? Icons.trending_up_rounded
                                : Icons.trending_down_rounded,
                            size: 13,
                            color: changeColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            Fmt.changePercent(change),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: changeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        widget.changeLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.caption.copyWith(fontSize: 11.5),
                      ),
                    ),
                  ],
                ),
              ],
              if (widget.footer != null) ...<Widget>[
                const SizedBox(height: AppSpacing.md),
                widget.footer!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
