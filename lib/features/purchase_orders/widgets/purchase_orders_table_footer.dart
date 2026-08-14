import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/purchase_orders_controller.dart';

/// فوتر الجدول: إجمالي قيمة الأوامر المعروضة وعددها.
class PurchaseOrdersTableFooter extends StatelessWidget {
  const PurchaseOrdersTableFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchaseOrdersController orders =
        context.watch<PurchaseOrdersController>();

    return Row(
      children: <Widget>[
        Text(
          'إجمالي قيمة الأوامر المعروضة: ${Fmt.money(orders.visibleValue)}',
          style: AppText.caption,
        ),
        const Spacer(),
        Text('${Fmt.count(orders.visibleCount)} أمر', style: AppText.caption),
      ],
    );
  }
}
