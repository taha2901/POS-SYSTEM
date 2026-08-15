import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/nav_list_tile.dart';
import '../../../theme/app_theme.dart';
import '../controllers/reports_controller.dart';
import '../models/report_type.dart';

/// قائمة أنواع التقارير الجانبية.
class ReportsList extends StatelessWidget {
  const ReportsList({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController reports = context.watch<ReportsController>();

    return Container(
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: <Widget>[
          for (final ReportType t in ReportType.values)
            NavListTile(
              icon: t.icon,
              label: t.label,
              description: t.description,
              selected: reports.type == t,
              onTap: () => reports.selectReport(t),
            ),
        ],
      ),
    );
  }
}
