import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// خلية الكمية المتاحة — لونها بيتغيّر حسب مستوى الرصيد.
class StockAvailableCell extends StatelessWidget {
  const StockAvailableCell({super.key, required this.available});

  final int available;

  @override
  Widget build(BuildContext context) {
    return Text(
      Fmt.count(available),
      style: AppText.amountSm.copyWith(
        color: available <= 0
            ? AppColors.danger
            : available < 10
                ? AppColors.warning
                : AppColors.success,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
