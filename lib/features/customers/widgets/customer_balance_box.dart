import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// صندوق الرصيد أعلى كشف الحساب.
class CustomerBalanceBox extends StatelessWidget {
  const CustomerBalanceBox({super.key, required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    final bool isDebtor = balance < 0;
    final Color color = isDebtor ? AppColors.danger : AppColors.success;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md - 2,
      ),
      decoration: BoxDecoration(
        color: isDebtor ? AppColors.dangerSoft : AppColors.successSoft,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            isDebtor ? 'المستحق على العميل' : 'الرصيد',
            style: AppText.bodyMedium.copyWith(fontSize: 13),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            Fmt.money(balance.abs()),
            style: AppText.amountLg.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
