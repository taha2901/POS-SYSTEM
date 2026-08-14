import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../models/payment_slice.dart';

/// قايمة طرق الدفع بنسبها أسفل الرسم.
class PaymentPieLegend extends StatelessWidget {
  const PaymentPieLegend({
    super.key,
    required this.slices,
    required this.total,
  });

  final List<PaymentSlice> slices;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final PaymentSlice slice in slices)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: <Widget>[
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: slice.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    slice.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.body.copyWith(fontSize: 12.5),
                  ),
                ),
                Text(
                  total == 0 ? '—' : Fmt.percent(slice.value / total * 100),
                  style: AppText.amountSm.copyWith(fontSize: 12.5),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
