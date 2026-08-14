import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/dashboard_controller.dart';
import '../models/dashboard_period.dart';
import 'dashboard_filter_bar.dart';

/// هيدر اللوحة: العنوان والفترة المختارة + شريط الفلترة.
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardPeriod period =
        context.select((DashboardController d) => d.period);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'لوحة التحكم',
                style: AppText.pageTitle.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 3),
              Text(
                'نظرة شاملة على أداء المتجر — ${period.label}',
                style: AppText.caption,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        const DashboardFilterBar(),
      ],
    );
  }
}
