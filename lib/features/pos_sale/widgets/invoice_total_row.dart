import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// صف الإجمالي النهائي بخط كبير أسفل ملخص الفاتورة.
class InvoiceTotalRow extends StatelessWidget {
  const InvoiceTotalRow({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'الإجمالي',
          style: AppText.sectionTitle.copyWith(fontSize: 15),
        ),
        const Spacer(),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerEnd,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(Fmt.amount(total), style: AppText.amountHero),
                const SizedBox(width: 6),
                Text(
                  Fmt.currencySymbol,
                  style: AppText.amountMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
