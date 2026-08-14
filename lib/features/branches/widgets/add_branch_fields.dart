import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_form_field.dart';
import '../../../theme/app_theme.dart';
import '../controllers/add_branch_controller.dart';

/// حقول نموذج الفرع: الاسم والعنوان والمسؤول.
class AddBranchFields extends StatelessWidget {
  const AddBranchFields({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBranchController form = context.read<AddBranchController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppFormField(
          label: 'اسم الفرع',
          controller: form.nameController,
          hint: 'مثال: فرع الشيخ زايد',
          required: true,
          onChanged: form.fieldChanged,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppFormField(
          label: 'العنوان',
          controller: form.addressController,
          hint: 'الشارع، الحي، المدينة',
          required: true,
          prefixIcon: Icons.location_on_outlined,
          onChanged: form.fieldChanged,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppFormField(
          label: 'المسؤول',
          controller: form.managerController,
          hint: 'اسم مدير الفرع',
          prefixIcon: Icons.person_outline_rounded,
        ),
      ],
    );
  }
}
