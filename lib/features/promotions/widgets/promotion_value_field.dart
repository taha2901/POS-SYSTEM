import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_form_field.dart';
import '../controllers/promotions_controller.dart';
import '../models/promotion_type_color.dart';

/// حقل قيمة الخصم — اللاحقة والـHint بيتغيّروا حسب نوع العرض.
class PromotionValueField extends StatelessWidget {
  const PromotionValueField({super.key});

  @override
  Widget build(BuildContext context) {
    final PromotionsController promotions =
        context.watch<PromotionsController>();

    return AppFormField(
      label: 'قيمة الخصم',
      controller: promotions.valueController,
      hint: promotions.formType.valueHint,
      required: true,
      suffixText: promotions.formType.valueSuffix,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      onChanged: promotions.formFieldChanged,
    );
  }
}
