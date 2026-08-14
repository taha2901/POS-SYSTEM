import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/suppliers_list_controller.dart';

/// فوتر الجدول: إجمالي المستحقات المعروضة وعدد الموردين.
class SuppliersTableFooter extends StatelessWidget {
  const SuppliersTableFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final SuppliersListController suppliers =
        context.watch<SuppliersListController>();

    return Row(
      children: <Widget>[
        Text(
          'إجمالي المستحقات المعروضة: ${Fmt.money(suppliers.visibleDue)}',
          style: AppText.caption,
        ),
        const Spacer(),
        Text(
          '${Fmt.count(suppliers.visibleCount)} مورد',
          style: AppText.caption,
        ),
      ],
    );
  }
}
