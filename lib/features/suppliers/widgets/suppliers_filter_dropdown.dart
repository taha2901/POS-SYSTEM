import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../controllers/suppliers_list_controller.dart';
import '../models/supplier_filter.dart';

/// فلتر حالة المورد.
class SuppliersFilterDropdown extends StatelessWidget {
  const SuppliersFilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final SuppliersListController suppliers =
        context.watch<SuppliersListController>();

    return AppDropdown<SupplierFilter>(
      value: suppliers.filter,
      width: 200,
      icon: Icons.filter_list_rounded,
      onChanged: suppliers.setFilter,
      items: <AppDropdownItem<SupplierFilter>>[
        for (final SupplierFilter f in SupplierFilter.values)
          AppDropdownItem<SupplierFilter>(value: f, label: f.label),
      ],
    );
  }
}
