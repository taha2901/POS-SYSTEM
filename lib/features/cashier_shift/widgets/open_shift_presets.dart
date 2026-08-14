import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/shift_controller.dart';

/// أزرار المبالغ الافتتاحية السريعة.
class OpenShiftPresets extends StatelessWidget {
  const OpenShiftPresets({super.key});

  @override
  Widget build(BuildContext context) {
    final ShiftController shift = context.watch<ShiftController>();

    return Row(
      children: <Widget>[
        for (final double v in ShiftController.presets) ...<Widget>[
          Expanded(
            child: SecondaryButton(
              label: Fmt.count(v),
              size: AppButtonSize.small,
              expanded: true,
              tone: shift.isPresetSelected(v)
                  ? SecondaryButtonTone.accent
                  : SecondaryButtonTone.neutral,
              onPressed: () => shift.setOpening(v),
            ),
          ),
          if (v != ShiftController.presets.last)
            const SizedBox(width: AppSpacing.sm),
        ],
      ],
    );
  }
}
