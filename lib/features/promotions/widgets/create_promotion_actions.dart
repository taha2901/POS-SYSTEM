import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/promotions_controller.dart';

/// أزرار الإلغاء والإنشاء في حوار العرض الجديد.
class CreatePromotionActions extends StatelessWidget {
  const CreatePromotionActions({super.key});

  @override
  Widget build(BuildContext context) {
    final PromotionsController promotions =
        context.watch<PromotionsController>();

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
            label: 'إنشاء العرض',
            icon: Icons.check_rounded,
            expanded: true,
            onPressed: promotions.isFormValid
                ? () => Navigator.of(context).pop(promotions.promotionName)
                : null,
          ),
        ),
      ],
    );
  }
}
