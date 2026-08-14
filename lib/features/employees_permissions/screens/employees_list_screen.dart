import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/employees_list_controller.dart';
import '../widgets/employees_filter_bar.dart';
import '../widgets/employees_stat_cards.dart';
import '../widgets/employees_table.dart';

/// شاشة الموظفين — بتجمّع الهيدر والبطاقات وشريط الفلترة والجدول بس.
class EmployeesListScreen extends StatelessWidget {
  const EmployeesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmployeesListController>(
      create: (_) => EmployeesListController(),
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ScreenHeader(
              title: 'الموظفين',
              subtitle: 'فريق العمل عبر كل الفروع وحالات الدخول',
              actions: <Widget>[
                SecondaryButton(
                  label: 'الأدوار والصلاحيات',
                  icon: Icons.shield_outlined,
                  tone: SecondaryButtonTone.accent,
                  onPressed: () => context.go('/employees/roles'),
                ),
                PrimaryButton(
                  label: 'إضافة موظف',
                  icon: Icons.person_add_alt_1_rounded,
                  onPressed: () => showPlainSnackBar(
                    context,
                    'فتح نموذج إضافة موظف جديد',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            const EmployeesStatCards(),
            const SizedBox(height: AppSpacing.xl),
            const EmployeesFilterBar(),
            const SizedBox(height: AppSpacing.lg),
            const Expanded(child: EmployeesTable()),
          ],
        ),
      ),
    );
  }
}
