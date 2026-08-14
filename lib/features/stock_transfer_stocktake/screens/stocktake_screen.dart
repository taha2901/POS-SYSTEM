import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/stocktake_controller.dart';
import '../widgets/stocktake_footer.dart';
import '../widgets/stocktake_header.dart';
import '../widgets/stocktake_table.dart';
import '../widgets/stocktake_toolbar.dart';

/// شاشة جرد المخزون — بتجمّع الهيدر وشريط الأدوات والجدول والفوتر بس.
class StocktakeScreen extends StatelessWidget {
  const StocktakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StocktakeController>(
      create: (_) => StocktakeController(),
      child: const Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xxl,
                AppSpacing.xxl,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  StocktakeHeader(),
                  SizedBox(height: AppSpacing.xl),
                  StocktakeToolbar(),
                  SizedBox(height: AppSpacing.lg),
                  Expanded(child: StocktakeTable()),
                  SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
          StocktakeFooter(),
        ],
      ),
    );
  }
}
