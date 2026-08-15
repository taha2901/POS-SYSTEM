import 'package:flutter/material.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../models/cart_discount.dart';

/// أزرار القيم السريعة تحت خانة الخصم — بتتغيّر حسب نوع الخصم.
class DiscountPresetsRow extends StatelessWidget {
  const DiscountPresetsRow({
    super.key,
    required this.type,
    required this.onSelected,
  });

  final DiscountType type;
  final ValueChanged<double> onSelected;

  @override
  Widget build(BuildContext context) {
    final List<double> presets = type.presets;

    return Row(
      children: <Widget>[
        for (int i = 0; i < presets.length; i++) ...<Widget>[
          Expanded(
            child: SecondaryButton(
              label: type == DiscountType.percent
                  ? '${presets[i].toInt()}%'
                  : Fmt.count(presets[i]),
              size: AppButtonSize.small,
              expanded: true,
              onPressed: () => onSelected(presets[i]),
            ),
          ),
          if (i != presets.length - 1) const SizedBox(width: AppSpacing.sm),
        ],
      ],
    );
  }
}
