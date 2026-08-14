import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_form_field.dart';
import '../../../theme/app_theme.dart';
import '../controllers/promotions_controller.dart';
import '../widgets/create_promotion_actions.dart';
import '../widgets/create_promotion_header.dart';
import '../widgets/promotion_date_range_fields.dart';
import '../widgets/promotion_type_field.dart';
import '../widgets/promotion_value_field.dart';

/// يفتح حوار إنشاء عرض ويرجّع اسم العرض (أو null لو اتلغى).
///
/// بياخد نفس [PromotionsController] بتاع الشاشة عشان نوع العرض المختار
/// يفضل جوه كنترولر واحد، وبيصفّر النموذج قبل كل فتح.
Future<String?> showCreatePromotionDialog(
  BuildContext context,
  PromotionsController promotions,
) {
  promotions.resetForm();

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) =>
        ChangeNotifierProvider<PromotionsController>.value(
      value: promotions,
      child: const CreatePromotionDialog(),
    ),
  );
}

/// حوار إنشاء عرض جديد — بيجمّع حقول النموذج بس.
class CreatePromotionDialog extends StatelessWidget {
  const CreatePromotionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final PromotionsController promotions =
        context.read<PromotionsController>();

    return Dialog(
      child: SizedBox(
        width: 560,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const CreatePromotionHeader(),
              const SizedBox(height: AppSpacing.xl),
              AppFormField(
                label: 'اسم العرض',
                controller: promotions.nameController,
                hint: 'مثال: خصم الصيف على المشروبات',
                required: true,
                onChanged: promotions.formFieldChanged,
              ),
              const SizedBox(height: AppSpacing.lg),
              const PromotionTypeField(),
              const SizedBox(height: AppSpacing.lg),
              const PromotionValueField(),
              const SizedBox(height: AppSpacing.lg),
              const PromotionDateRangeFields(),
              const SizedBox(height: AppSpacing.xxl),
              const CreatePromotionActions(),
            ],
          ),
        ),
      ),
    );
  }
}
