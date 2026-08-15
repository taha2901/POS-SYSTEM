import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../models/cart_discount.dart';

/// مفتاح التبديل بين خصم بمبلغ ثابت وخصم بنسبة.
class DiscountTypeToggle extends StatelessWidget {
  const DiscountTypeToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final DiscountType selected;
  final ValueChanged<DiscountType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: <Widget>[
          for (final DiscountType t in DiscountType.values)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(t),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected == t
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: AppRadius.smAll,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          t == DiscountType.amount
                              ? Icons.payments_outlined
                              : Icons.percent_rounded,
                          size: 16,
                          color: selected == t
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          t.label,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: selected == t
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected == t
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
