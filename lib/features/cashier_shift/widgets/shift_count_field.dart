import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/shift_controller.dart';

/// بطاقة العدّ الفعلي للنقدية.
class ShiftCountField extends StatelessWidget {
  const ShiftCountField({super.key});

  @override
  Widget build(BuildContext context) {
    final ShiftController shift = context.read<ShiftController>();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: AppDecorations.card(),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.calculate_outlined,
                      size: 17,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'العدّ الفعلي للنقدية',
                      style: AppText.cardTitle.copyWith(fontSize: 14.5),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'اعدّ النقدية الموجودة في الدرج وأدخل المبلغ الفعلي',
                  style: AppText.caption.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
          SizedBox(
            width: 240,
            height: 62,
            child: TextField(
              controller: shift.countController,
              autofocus: true,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              onChanged: shift.countChanged,
              style: AppText.amountHero.copyWith(fontSize: 26),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: AppText.amountHero.copyWith(
                  fontSize: 26,
                  color: AppColors.textMuted,
                ),
                suffixText: Fmt.currencySymbol,
                suffixStyle: AppText.caption.copyWith(fontSize: 13),
                fillColor: AppColors.surfaceAlt,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
