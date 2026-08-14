import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/inventory_controller.dart';

/// فوتر الجدول: إجمالي القيمة المعروضة وعدد الصفوف.
class InventoryTableFooter extends StatelessWidget {
  const InventoryTableFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final InventoryController inventory = context.watch<InventoryController>();

    return Row(
      children: <Widget>[
        Text(
          'إجمالي القيمة المعروضة: ${Fmt.money(inventory.visibleValue)}',
          style: AppText.caption,
        ),
        const Spacer(),
        Text(
          '${Fmt.count(inventory.visibleCount)} صف',
          style: AppText.caption,
        ),
      ],
    );
  }
}
