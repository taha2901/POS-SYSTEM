import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../theme/app_theme.dart';
import '../controllers/branches_controller.dart';
import '../models/draft_branch.dart';
import '../widgets/branches_grid.dart';
import '../widgets/branches_section_title.dart';
import '../widgets/branches_stat_cards.dart';
import 'add_branch_dialog.dart';

/// شاشة الفروع — بتجمّع البطاقات الإحصائية وشبكة الفروع بس.
class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  Future<void> _addBranch(BuildContext context) async {
    final BranchesController branches = context.read<BranchesController>();

    final DraftBranch? created = await showAddBranchDialog(context);
    if (created == null || !context.mounted) return;

    branches.addDraft(created);
    showPlainSnackBar(
      context,
      'تم إضافة «${created.name}» (تجريبي)',
      width: 460,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BranchesController>(
      create: (_) => BranchesController(),
      child: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: AppSpacing.page,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ScreenHeader(
                  title: 'الفروع',
                  subtitle: 'إدارة فروع المتجر ومتابعة أدائها اليومي',
                  actions: <Widget>[
                    PrimaryButton(
                      label: 'إضافة فرع جديد',
                      icon: Icons.add_business_outlined,
                      onPressed: () => _addBranch(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                const BranchesStatCards(),
                const SizedBox(height: AppSpacing.xl),
                const BranchesSectionTitle(),
                const SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: BranchesGrid(
                    onAddBranch: () => _addBranch(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
