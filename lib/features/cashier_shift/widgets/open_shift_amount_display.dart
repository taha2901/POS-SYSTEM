import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/shift_controller.dart';

/// الحقل الكبير المتمركز اللي بيعرض الرصيد الافتتاحي.
class OpenShiftAmountDisplay extends StatelessWidget {
  const OpenShiftAmountDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final ShiftController shift = context.watch<ShiftController>();
    final bool isValid = shift.isOpeningValid;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: AppRadius.xlAll,
        border: Border.all(
          color: isValid ? AppColors.accent : AppColors.borderStrong,
          width: isValid ? 1.6 : 1,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.savings_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'الرصيد الافتتاحي في الدرج',
                style: AppText.label.copyWith(fontSize: 12.5),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  shift.openingText,
                  style: AppText.amountHero.copyWith(
                    fontSize: 56,
                    letterSpacing: -1.5,
                    color: isValid
                        ? AppColors.textPrimary
                        : AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  Fmt.currencySymbol,
                  style: AppText.amountLg.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
