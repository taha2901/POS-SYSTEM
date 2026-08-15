import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_theme.dart';
import '../models/quick_link.dart';
import 'quick_link_card.dart';

/// صف الاختصارات السريعة أسفل شاشة الترحيب.
class WelcomeQuickLinks extends StatelessWidget {
  const WelcomeQuickLinks({super.key});

  static const List<QuickLink> _links = <QuickLink>[
    QuickLink(
      label: 'نقطة البيع',
      icon: Icons.point_of_sale_rounded,
      route: '/pos',
    ),
    QuickLink(
      label: 'المنتجات',
      icon: Icons.inventory_2_outlined,
      route: '/products',
    ),
    QuickLink(
      label: 'التقارير',
      icon: Icons.bar_chart_rounded,
      route: '/reports',
    ),
    QuickLink(
      label: 'العملاء',
      icon: Icons.people_alt_outlined,
      route: '/customers',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.lg,
      alignment: WrapAlignment.center,
      children: <Widget>[
        for (final QuickLink link in _links)
          QuickLinkCard(
            label: link.label,
            icon: link.icon,
            onTap: () => context.go(link.route),
          ),
      ],
    );
  }
}
