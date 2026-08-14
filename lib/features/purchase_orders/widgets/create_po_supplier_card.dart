import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/create_purchase_order_controller.dart';
import 'create_po_supplier_contact.dart';

/// بطاقة اختيار المورد وفرع الاستلام.
class CreatePoSupplierCard extends StatelessWidget {
  const CreatePoSupplierCard({super.key});

  @override
  Widget build(BuildContext context) {
    final CreatePurchaseOrderController draft =
        context.watch<CreatePurchaseOrderController>();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: AppDecorations.card(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: LabeledField(
              label: 'المورد',
              child: AppDropdown<String>(
                value: draft.supplierId,
                width: double.infinity,
                height: 48,
                icon: Icons.local_shipping_outlined,
                onChanged: draft.setSupplier,
                items: <AppDropdownItem<String>>[
                  for (final Supplier s in MockData.suppliers)
                    AppDropdownItem<String>(
                      value: s.id,
                      label: s.name,
                      icon: Icons.storefront_outlined,
                      trailing: s.isActive ? null : 'موقوف',
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: LabeledField(
              label: 'فرع الاستلام',
              child: AppDropdown<String>(
                value: draft.branchId,
                width: double.infinity,
                height: 48,
                icon: Icons.store_outlined,
                onChanged: draft.setBranch,
                items: <AppDropdownItem<String>>[
                  for (final Branch b in MockData.branches)
                    AppDropdownItem<String>(value: b.id, label: b.name),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
          const Expanded(flex: 2, child: CreatePoSupplierContact()),
        ],
      ),
    );
  }
}
