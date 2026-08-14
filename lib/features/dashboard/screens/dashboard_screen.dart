import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/staggered_reveal.dart';
import '../../../theme/app_theme.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/dashboard_charts_row.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_stats_row.dart';
import '../widgets/dashboard_tables_row.dart';

/// لوحة التحكم — بتجمّع الهيدر والبطاقات والرسوم والجداول بس.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  /// الكنترولر محتاج vsync عشان أنيميشن الدخول المتدرّج.
  late final DashboardController _dashboard =
      DashboardController(vsync: this);

  @override
  void dispose() {
    _dashboard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardController>.value(
      value: _dashboard,
      child: Padding(
        padding: AppSpacing.page,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StaggeredReveal(
                controller: _dashboard.entryController,
                index: 0,
                child: const DashboardHeader(),
              ),
              const SizedBox(height: AppSpacing.xl),
              const DashboardStatsRow(),
              const SizedBox(height: AppSpacing.xl),
              const DashboardChartsRow(),
              const SizedBox(height: AppSpacing.xl),
              const DashboardTablesRow(),
            ],
          ),
        ),
      ),
    );
  }
}
