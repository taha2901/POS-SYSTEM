import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/inventory_controller.dart';
import '../widgets/inventory_filter_bar.dart';
import '../widgets/inventory_header.dart';
import '../widgets/inventory_stat_cards.dart';
import '../widgets/inventory_table.dart';

/// شاشة المخزون — بتجمّع الهيدر والبطاقات وشريط الفلترة والجدول بس.
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InventoryController>(
      create: (_) => InventoryController(),
      child: Padding(
        padding: AppSpacing.page,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InventoryHeader(),
            SizedBox(height: AppSpacing.xl),
            InventoryStatCards(),
            SizedBox(height: AppSpacing.xl),
            InventoryFilterBar(),
            SizedBox(height: AppSpacing.lg),
            Expanded(child: InventoryTable()),
          ],
        ),
      ),
    );
  }
}
