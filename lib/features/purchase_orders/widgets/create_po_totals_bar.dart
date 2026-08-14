import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/create_purchase_order_controller.dart';
import 'create_po_grand_total.dart';
import 'create_po_total_item.dart';

/// الشريط السفلي: الإجماليات وأزرار الحفظ والاعتماد.
class CreatePoTotalsBar extends StatelessWidget {
  const CreatePoTotalsBar({super.key});

  void _save(BuildContext context, {required bool confirm}) {
    final CreatePurchaseOrderController draft =
        context.read<CreatePurchaseOrderController>();

    showPlainSnackBar(
      context,
      confirm
          ? 'تم إنشاء أمر الشراء واعتماده بقيمة ${Fmt.money(draft.total)} (تجريبي)'
          : 'تم حفظ أمر الشراء كمسودة (تجريبي)',
      width: 460,
    );
    context.go('/purchases');
  }

  @override
  Widget build(BuildContext context) {
    final CreatePurchaseOrderController draft =
        context.watch<CreatePurchaseOrderController>();
    final bool hasLines = draft.hasLines;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x0F0F172A),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // الإجماليات بتتزحلق أفقيًا لو المساحة ضاقت بدل ما تفيض
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  CreatePoTotalItem(
                    label: 'المجموع الفرعي',
                    value: Fmt.money(draft.subtotal),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  CreatePoTotalItem(
                    label: 'الضريبة '
                        '(${(MockData.taxRate * 100).toStringAsFixed(0)}%)',
                    value: Fmt.money(draft.tax),
                  ),
                  Container(
                    width: 1,
                    height: 44,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                    color: AppColors.border,
                  ),
                  const CreatePoGrandTotal(),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          SecondaryButton(
            label: 'حفظ كمسودة',
            icon: Icons.save_outlined,
            size: AppButtonSize.large,
            onPressed: hasLines ? () => _save(context, confirm: false) : null,
          ),
          const SizedBox(width: AppSpacing.md),
          PrimaryButton(
            label: 'إنشاء واعتماد الأمر',
            icon: Icons.check_circle_outline_rounded,
            size: AppButtonSize.large,
            onPressed: hasLines ? () => _save(context, confirm: true) : null,
          ),
        ],
      ),
    );
  }
}
