import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// خلية الرصيد المستحق للمورد.
class SupplierDueCell extends StatelessWidget {
  const SupplierDueCell({super.key, required this.balanceDue});

  final double balanceDue;

  @override
  Widget build(BuildContext context) {
    final bool hasDue = balanceDue > 0;

    return Text(
      hasDue ? Fmt.money(balanceDue) : '—',
      style: AppText.amountSm.copyWith(
        color: hasDue ? AppColors.danger : AppColors.success,
        fontWeight: hasDue ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }
}
