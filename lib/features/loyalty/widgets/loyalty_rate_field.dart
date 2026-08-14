import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/loyalty_controller.dart';

/// خانة عدد النقاط لكل جنيه.
class LoyaltyRateField extends StatelessWidget {
  const LoyaltyRateField({super.key});

  @override
  Widget build(BuildContext context) {
    final LoyaltyController loyalty = context.read<LoyaltyController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('نقطة لكل جنيه', style: AppText.label.copyWith(fontSize: 12)),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 52,
          child: TextField(
            controller: loyalty.rateController,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            onChanged: loyalty.rateChanged,
            style: AppText.amountLg.copyWith(fontSize: 20),
            decoration: const InputDecoration(
              fillColor: AppColors.surfaceAlt,
              prefixIcon: Icon(Icons.stars_outlined, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
