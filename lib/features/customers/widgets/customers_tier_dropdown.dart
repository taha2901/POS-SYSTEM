import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../mock_data/mock_data.dart';
import '../../../utils/formatters.dart';
import '../controllers/customers_list_controller.dart';
import '../models/customer_tier_tone.dart';

/// فلتر مجموعة العميل.
class CustomersTierDropdown extends StatelessWidget {
  const CustomersTierDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomersListController customers =
        context.watch<CustomersListController>();

    return AppDropdown<CustomerTier?>(
      value: customers.tier,
      width: 190,
      icon: Icons.workspace_premium_outlined,
      onChanged: customers.setTier,
      items: <AppDropdownItem<CustomerTier?>>[
        AppDropdownItem<CustomerTier?>(
          value: null,
          label: 'كل المجموعات',
          icon: Icons.apps_rounded,
          trailing: Fmt.count(customers.allCustomers.length),
        ),
        for (final CustomerTier t in CustomerTier.values)
          AppDropdownItem<CustomerTier?>(
            value: t,
            label: t.shortLabel,
            trailing: Fmt.count(customers.tierCount(t)),
          ),
      ],
    );
  }
}
