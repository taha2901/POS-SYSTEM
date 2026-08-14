import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../theme/app_theme.dart';
import '../controllers/suppliers_list_controller.dart';
import '../widgets/suppliers_filter_bar.dart';
import '../widgets/suppliers_stat_cards.dart';
import '../widgets/suppliers_table.dart';

/// شاشة الموردين — بتجمّع الهيدر والبطاقات وشريط الفلترة والجدول بس.
class SuppliersListScreen extends StatelessWidget {
  const SuppliersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SuppliersListController>(
      create: (_) => SuppliersListController(),
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ScreenHeader(
              title: 'الموردين',
              subtitle: 'إدارة الموردين والمستحقات وأوامر التوريد',
              actions: <Widget>[
                PrimaryButton(
                  label: 'إضافة مورد',
                  icon: Icons.add_business_outlined,
                  onPressed: () => showPlainSnackBar(
                    context,
                    'فتح نموذج إضافة مورد جديد',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            const SuppliersStatCards(),
            const SizedBox(height: AppSpacing.xl),
            const SuppliersFilterBar(),
            const SizedBox(height: AppSpacing.lg),
            const Expanded(child: SuppliersTable()),
          ],
        ),
      ),
    );
  }
}
