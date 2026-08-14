import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/staggered_reveal.dart';
import '../../../theme/app_theme.dart';
import '../controllers/dashboard_controller.dart';
import 'top_branches_card.dart';
import 'top_products_card.dart';

/// صف الجدولين: أفضل المنتجات + أفضل الفروع.
class DashboardTablesRow extends StatelessWidget {
  const DashboardTablesRow({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController entry =
        context.read<DashboardController>().entryController;

    return SizedBox(
      height: 420,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: StaggeredReveal(
              controller: entry,
              index: 7,
              child: const TopProductsCard(),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: StaggeredReveal(
              controller: entry,
              index: 8,
              child: const TopBranchesCard(),
            ),
          ),
        ],
      ),
    );
  }
}
