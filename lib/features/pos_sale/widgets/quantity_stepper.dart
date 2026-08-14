import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import 'quantity_stepper_button.dart';

/// عدّاد الكمية في سطر السلة.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          QuantityStepperButton(
            icon: Icons.remove_rounded,
            onTap: onDecrement,
            tooltip: 'تقليل',
          ),
          SizedBox(
            width: 34,
            child: Text(
              Fmt.count(quantity),
              textAlign: TextAlign.center,
              style: AppText.amountSm.copyWith(fontSize: 14),
            ),
          ),
          QuantityStepperButton(
            icon: Icons.add_rounded,
            onTap: onIncrement,
            tooltip: 'زيادة',
            accent: true,
          ),
        ],
      ),
    );
  }
}
