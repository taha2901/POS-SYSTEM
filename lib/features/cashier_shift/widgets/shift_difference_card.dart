import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/shift_controller.dart';
import '../models/shift_diff_style.dart';
import 'shift_expected_actual_item.dart';

/// بطاقة الفرق بين المتوقّع والعدّ الفعلي.
class ShiftDifferenceCard extends StatelessWidget {
  const ShiftDifferenceCard({super.key});

  /// إشارة الفرق: + للزيادة و− للعجز.
  String _differenceText(ShiftController shift) {
    if (!shift.isCounted) return '—';

    final double diff = shift.difference;
    final String sign = diff > 0
        ? '+ '
        : diff < 0
            ? '− '
            : '';
    return '$sign${Fmt.money(diff.abs())}';
  }

  @override
  Widget build(BuildContext context) {
    final ShiftController shift = context.watch<ShiftController>();
    final ShiftDiffStyle style = shift.diffStyle;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: AppRadius.xlAll,
        border: Border.all(
          color: style.color.withValues(alpha: 0.28),
          width: 1.5,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: ShiftExpectedActualItem(
                  label: 'المتوقّع في الدرج',
                  value: Fmt.money(shift.expected),
                  icon: Icons.inventory_2_outlined,
                ),
              ),
              Container(
                width: 1,
                height: 44,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                color: style.color.withValues(alpha: 0.2),
              ),
              Expanded(
                child: ShiftExpectedActualItem(
                  label: 'العدّ الفعلي',
                  value: shift.isCounted ? Fmt.money(shift.actual!) : '—',
                  icon: Icons.calculate_outlined,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Divider(
              height: 1,
              color: style.color.withValues(alpha: 0.18),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: style.color.withValues(alpha: 0.14),
                  borderRadius: AppRadius.mdAll,
                ),
                child: Icon(style.icon, size: 26, color: style.color),
              ),
              const SizedBox(width: AppSpacing.lg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('الفرق', style: AppText.label.copyWith(fontSize: 12.5)),
                  const SizedBox(height: 2),
                  Text(
                    style.label,
                    style: AppText.cardTitle.copyWith(
                      fontSize: 14,
                      color: style.color,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    _differenceText(shift),
                    style: AppText.amountHero.copyWith(
                      fontSize: 44,
                      color: style.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
