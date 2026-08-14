import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// عنصر رقمي داخل بطاقة الملخص
class ProfileStat {
  const ProfileStat({
    required this.label,
    required this.value,
    this.color,
    this.icon,
    this.big = false,
  });

  final String label;
  final String value;
  final Color? color;
  final IconData? icon;
  final bool big;
}

/// بطاقة الملخص الأفقية أعلى صفحات العملاء والموردين.
class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.stats,
    this.badge,
    this.avatarColor = AppColors.accent,
    this.avatarIcon,
    this.actions = const <Widget>[],
    this.meta = const <(IconData, String)>[],
  });

  final String name;
  final String subtitle;
  final List<ProfileStat> stats;
  final Widget? badge;
  final Color avatarColor;
  final IconData? avatarIcon;
  final List<Widget> actions;

  /// معلومات صغيرة تحت الاسم (هاتف، بريد، …)
  final List<(IconData, String)> meta;

  String get _initial {
    final String trimmed = name.trim();
    return trimmed.isEmpty ? '؟' : trimmed.characters.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // الأفاتار
          Container(
            width: 78,
            height: 78,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  avatarColor,
                  Color.alphaBlend(
                    Colors.black.withValues(alpha: 0.25),
                    avatarColor,
                  ),
                ],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: avatarColor.withValues(alpha: 0.32),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: avatarIcon != null
                ? Icon(avatarIcon, size: 34, color: Colors.white)
                : Text(
                    _initial,
                    style: AppText.amountHero.copyWith(
                      fontSize: 34,
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(width: AppSpacing.xl),

          // الاسم والبيانات
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.pageTitle.copyWith(fontSize: 21),
                      ),
                    ),
                    if (badge != null) ...<Widget>[
                      const SizedBox(width: AppSpacing.md),
                      badge!,
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption,
                ),
                if (meta.isNotEmpty) ...<Widget>[
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.lg,
                    runSpacing: AppSpacing.sm,
                    children: <Widget>[
                      for (final (IconData icon, String text) item in meta)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              item.$1,
                              size: 14,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              item.$2,
                              style: AppText.caption.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // الأرقام
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                for (int i = 0; i < stats.length; i++) ...<Widget>[
                  if (i > 0)
                    Container(
                      width: 1,
                      height: 42,
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      color: AppColors.border,
                    ),
                  Flexible(child: _buildStat(stats[i])),
                ],
              ],
            ),
          ),

          if (actions.isNotEmpty) ...<Widget>[
            const SizedBox(width: AppSpacing.xl),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (int i = 0; i < actions.length; i++) ...<Widget>[
                  if (i > 0) const SizedBox(height: AppSpacing.sm),
                  actions[i],
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStat(ProfileStat stat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            if (stat.icon != null) ...<Widget>[
              Icon(
                stat.icon,
                size: 13,
                color: stat.color ?? AppColors.textMuted,
              ),
              const SizedBox(width: 5),
            ],
            Flexible(
              child: Text(
                stat.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.label.copyWith(fontSize: 11.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            stat.value,
            style: (stat.big ? AppText.amountHero : AppText.amountLg).copyWith(
              fontSize: stat.big ? 28 : 20,
              color: stat.color ?? AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
