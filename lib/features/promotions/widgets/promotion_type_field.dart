import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../mock_data/mock_data.dart';
import '../controllers/promotions_controller.dart';

/// اختيار نوع العرض في الفورم.
class PromotionTypeField extends StatelessWidget {
  const PromotionTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    final PromotionsController promotions =
        context.watch<PromotionsController>();

    return LabeledField(
      label: 'نوع العرض',
      child: AppDropdown<PromotionType>(
        value: promotions.formType,
        width: double.infinity,
        height: 48,
        onChanged: promotions.setFormType,
        items: <AppDropdownItem<PromotionType>>[
          for (final PromotionType t in PromotionType.values)
            AppDropdownItem<PromotionType>(
              value: t,
              label: t.label,
              icon: t.icon,
            ),
        ],
      ),
    );
  }
}
