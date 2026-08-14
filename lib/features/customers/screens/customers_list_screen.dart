import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../theme/app_theme.dart';
import '../controllers/customers_list_controller.dart';
import '../widgets/customers_filter_bar.dart';
import '../widgets/customers_stat_cards.dart';
import '../widgets/customers_table.dart';

/// شاشة العملاء — بتجمّع الهيدر والبطاقات وشريط الفلترة والجدول بس.
class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomersListController>(
      create: (_) => CustomersListController(),
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ScreenHeader(
              title: 'العملاء',
              subtitle: 'إدارة قاعدة العملاء وأرصدتهم ونقاط الولاء',
              actions: <Widget>[
                PrimaryButton(
                  label: 'إضافة عميل',
                  icon: Icons.person_add_alt_1_rounded,
                  onPressed: () => showPlainSnackBar(
                    context,
                    'فتح نموذج إضافة عميل جديد',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            const CustomersStatCards(),
            const SizedBox(height: AppSpacing.xl),
            const CustomersFilterBar(),
            const SizedBox(height: AppSpacing.lg),
            const Expanded(child: CustomersTable()),
          ],
        ),
      ),
    );
  }
}
