import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../mock_data/mock_data.dart';
import '../../../utils/formatters.dart';
import '../controllers/purchase_orders_controller.dart';

/// فلتر حالة الأمر فوق الجدول.
class PurchaseOrdersStatusDropdown extends StatelessWidget {
  const PurchaseOrdersStatusDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchaseOrdersController orders =
        context.watch<PurchaseOrdersController>();

    return AppDropdown<PurchaseOrderStatus?>(
      value: orders.status,
      width: 190,
      icon: Icons.flag_outlined,
      onChanged: orders.setStatus,
      items: <AppDropdownItem<PurchaseOrderStatus?>>[
        const AppDropdownItem<PurchaseOrderStatus?>(
          value: null,
          label: 'كل الحالات',
          icon: Icons.apps_rounded,
        ),
        for (final PurchaseOrderStatus s in PurchaseOrderStatus.values)
          AppDropdownItem<PurchaseOrderStatus?>(
            value: s,
            label: s.label,
            trailing: Fmt.count(orders.countByStatus(s)),
          ),
      ],
    );
  }
}
