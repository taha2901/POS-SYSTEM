import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/add_branch_controller.dart';

/// أزرار الإلغاء والإضافة في حوار الفرع.
class AddBranchActions extends StatelessWidget {
  const AddBranchActions({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBranchController form = context.watch<AddBranchController>();

    return Row(
      children: <Widget>[
        Expanded(
          child: SecondaryButton(
            label: 'إلغاء',
            expanded: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          flex: 2,
          child: PrimaryButton(
            label: 'إضافة الفرع',
            icon: Icons.check_rounded,
            expanded: true,
            onPressed: form.isValid
                ? () => Navigator.of(context).pop(form.build())
                : null,
          ),
        ),
      ],
    );
  }
}
