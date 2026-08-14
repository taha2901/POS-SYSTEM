import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// خلية الكمية المحجوزة — شرطة رمادية لو مفيش حجز.
class StockReservedCell extends StatelessWidget {
  const StockReservedCell({super.key, required this.reserved});

  final int reserved;

  @override
  Widget build(BuildContext context) {
    return Text(
      reserved == 0 ? '—' : Fmt.count(reserved),
      style: AppText.amountSm.copyWith(
        color: reserved == 0 ? AppColors.textMuted : AppColors.warning,
      ),
    );
  }
}
