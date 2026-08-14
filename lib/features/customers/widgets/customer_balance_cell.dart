import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// خلية الرصيد: أحمر = مدين، أخضر = دائن، رمادي = صفر.
class CustomerBalanceCell extends StatelessWidget {
  const CustomerBalanceCell({super.key, required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Text(
      balance == 0 ? '—' : Fmt.money(balance.abs()),
      style: AppText.amountSm.copyWith(
        color: balance < 0
            ? AppColors.danger
            : balance > 0
                ? AppColors.success
                : AppColors.textMuted,
        fontWeight: balance == 0 ? FontWeight.w500 : FontWeight.w700,
      ),
    );
  }
}
