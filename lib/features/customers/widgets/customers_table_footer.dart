import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/customers_list_controller.dart';

/// فوتر الجدول: إجمالي أرصدة العملاء المعروضين وعددهم.
class CustomersTableFooter extends StatelessWidget {
  const CustomersTableFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomersListController customers =
        context.watch<CustomersListController>();

    return Row(
      children: <Widget>[
        Text(
          'إجمالي أرصدة العملاء المعروضين: '
          '${Fmt.money(customers.visibleBalance)}',
          style: AppText.caption,
        ),
        const Spacer(),
        Text(
          '${Fmt.count(customers.visibleCount)} عميل',
          style: AppText.caption,
        ),
      ],
    );
  }
}
