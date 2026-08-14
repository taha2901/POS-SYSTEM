import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/app_form_field.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/add_expense_controller.dart';
import 'attachment_drop_zone.dart';

/// حقول نموذج المصروف: الفئة والمبلغ والفرع والملاحظة والمرفق.
class AddExpenseFields extends StatelessWidget {
  const AddExpenseFields({super.key});

  @override
  Widget build(BuildContext context) {
    final AddExpenseController form = context.watch<AddExpenseController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: LabeledField(
                label: 'الفئة',
                child: AppDropdown<String>(
                  value: form.category,
                  width: double.infinity,
                  height: 48,
                  icon: Icons.category_outlined,
                  onChanged: form.setCategory,
                  items: <AppDropdownItem<String>>[
                    for (final String c in MockData.expenseCategories)
                      AppDropdownItem<String>(value: c, label: c),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: AppFormField(
                label: 'المبلغ',
                controller: form.amountController,
                hint: '0.00',
                required: true,
                suffixText: Fmt.currencySymbol,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                onChanged: form.amountChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        LabeledField(
          label: 'الفرع',
          child: AppDropdown<String>(
            value: form.branchId,
            width: double.infinity,
            height: 48,
            icon: Icons.store_outlined,
            onChanged: form.setBranch,
            items: <AppDropdownItem<String>>[
              for (final Branch b in MockData.branches)
                AppDropdownItem<String>(value: b.id, label: b.name),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppFormField(
          label: 'ملاحظة',
          controller: form.noteController,
          hint: 'وصف مختصر للمصروف…',
          maxLines: 3,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('المرفق', style: AppText.label.copyWith(fontSize: 12.5)),
        const SizedBox(height: AppSpacing.sm),
        const AttachmentDropZone(),
      ],
    );
  }
}
