import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/branches_controller.dart';
import '../models/draft_branch.dart';
import 'add_branch_card.dart';
import 'branch_card.dart';
import 'draft_branch_card.dart';

/// شبكة بطاقات الفروع + بطاقة الإضافة في آخرها.
class BranchesGrid extends StatelessWidget {
  const BranchesGrid({super.key, required this.onAddBranch});

  final VoidCallback onAddBranch;

  @override
  Widget build(BuildContext context) {
    final BranchesController branches = context.watch<BranchesController>();

    return GridView(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        mainAxisExtent: 260,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
      ),
      children: <Widget>[
        for (final Branch b in MockData.branches) BranchCard(branch: b),
        for (final DraftBranch d in branches.drafts)
          DraftBranchCard(draft: d),
        AddBranchCard(onTap: onAddBranch),
      ],
    );
  }
}
