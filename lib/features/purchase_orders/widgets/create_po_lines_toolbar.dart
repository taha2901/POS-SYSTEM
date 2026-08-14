import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/product_picker_dialog.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/create_purchase_order_controller.dart';

/// يفتح نافذة اختيار منتج ويضيفه للأمر.
Future<void> pickProductForOrder(BuildContext context) async {
  final CreatePurchaseOrderController draft =
      context.read<CreatePurchaseOrderController>();

  final Product? product = await showProductPicker(
    context,
    excludedIds: draft.pickedProductIds,
  );
  if (product == null) return;

  draft.addProduct(product);
}

/// شريط عنوان جدول الأصناف مع أزرار الإضافة.
class CreatePoLinesToolbar extends StatelessWidget {
  const CreatePoLinesToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final CreatePurchaseOrderController draft =
        context.watch<CreatePurchaseOrderController>();

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: <Widget>[
          Text('أصناف الأمر', style: AppText.sectionTitle),
          const SizedBox(width: AppSpacing.sm),
          if (draft.hasLines)
            Text(
              '(${Fmt.count(draft.lines.length)} صنف • '
              '${Fmt.count(draft.totalUnits)} وحدة)',
              style: AppText.caption,
            ),
          const Spacer(),
          SecondaryButton(
            label: 'إضافة كتالوج المورد',
            icon: Icons.library_add_outlined,
            size: AppButtonSize.small,
            onPressed: draft.addSupplierCatalog,
          ),
          const SizedBox(width: AppSpacing.sm),
          PrimaryButton(
            label: 'إضافة صنف',
            icon: Icons.add_rounded,
            size: AppButtonSize.small,
            onPressed: () => pickProductForOrder(context),
          ),
        ],
      ),
    );
  }
}
