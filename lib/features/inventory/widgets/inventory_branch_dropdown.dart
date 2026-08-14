import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../mock_data/mock_data.dart';
import '../../../utils/formatters.dart';
import '../controllers/inventory_controller.dart';

/// فلتر الفرع أو المخزن.
class InventoryBranchDropdown extends StatelessWidget {
  const InventoryBranchDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final InventoryController inventory = context.watch<InventoryController>();

    return AppDropdown<String?>(
      value: inventory.branchId,
      width: 240,
      icon: Icons.store_outlined,
      onChanged: inventory.setBranch,
      items: <AppDropdownItem<String?>>[
        AppDropdownItem<String?>(
          value: null,
          label: 'كل الفروع والمخازن',
          icon: Icons.apps_rounded,
          trailing: Fmt.count(MockData.stockRecords.length),
        ),
        for (final Branch b in MockData.branches)
          AppDropdownItem<String?>(
            value: b.id,
            label: b.name,
            icon: b.isMain ? Icons.star_rounded : Icons.store_outlined,
            trailing: Fmt.count(MockData.stockByBranch(b.id).length),
          ),
      ],
    );
  }
}
