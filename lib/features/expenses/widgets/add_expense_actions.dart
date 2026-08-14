import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/add_expense_controller.dart';

/// أزرار الإلغاء والحفظ في حوار المصروف.
class AddExpenseActions extends StatelessWidget {
  const AddExpenseActions({super.key});

  @override
  Widget build(BuildContext context) {
    final AddExpenseController form = context.watch<AddExpenseController>();

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
            label: 'حفظ المصروف',
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
