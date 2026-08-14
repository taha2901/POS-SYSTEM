import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/add_branch_controller.dart';
import '../models/draft_branch.dart';
import '../widgets/add_branch_actions.dart';
import '../widgets/add_branch_fields.dart';
import '../widgets/add_branch_header.dart';

/// يفتح حوار إضافة فرع ويرجّع الفرع الجديد (أو null لو اتلغى).
Future<DraftBranch?> showAddBranchDialog(BuildContext context) {
  return showDialog<DraftBranch>(
    context: context,
    builder: (BuildContext context) => const AddBranchDialog(),
  );
}

/// حوار إضافة فرع — بيجمّع الهيدر والحقول والأزرار بس.
class AddBranchDialog extends StatelessWidget {
  const AddBranchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBranchController>(
      create: (_) => AddBranchController(),
      child: Dialog(
        child: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AddBranchHeader(),
                SizedBox(height: AppSpacing.xl),
                AddBranchFields(),
                SizedBox(height: AppSpacing.xxl),
                AddBranchActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
