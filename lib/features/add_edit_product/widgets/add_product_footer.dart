import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/product_form_controller.dart';
import '../models/product_form_tab.dart';

/// الشريط السفلي الثابت: حالة النموذج وأزرار الإلغاء والحفظ.
class AddProductFooter extends StatelessWidget {
  const AddProductFooter({super.key});

  void _save(BuildContext context) {
    final ProductFormController form = context.read<ProductFormController>();

    if (!form.hasName) {
      form.goToTab(ProductFormTab.basic);
      showPlainSnackBar(context, 'من فضلك أدخل اسم المنتج أولاً');
      return;
    }

    showPlainSnackBar(context, 'تم حفظ «${form.productName}» (تجريبي)');
    context.go('/products');
  }

  @override
  Widget build(BuildContext context) {
    final ProductFormController form = context.watch<ProductFormController>();
    final bool hasName = form.hasName;

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
          Icon(
            hasName
                ? Icons.check_circle_outline_rounded
                : Icons.edit_note_rounded,
            size: 18,
            color: hasName ? AppColors.success : AppColors.textMuted,
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              hasName
                  ? 'جاهز للحفظ: ${form.productName}'
                  : 'لم يتم إدخال اسم المنتج بعد',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.caption.copyWith(fontSize: 12.5),
            ),
          ),
          const Spacer(),
          SecondaryButton(
            label: 'إلغاء',
            size: AppButtonSize.large,
            onPressed: () => context.go('/products'),
          ),
          const SizedBox(width: AppSpacing.md),
          PrimaryButton(
            label: 'حفظ المنتج',
            icon: Icons.save_outlined,
            size: AppButtonSize.large,
            onPressed: () => _save(context),
          ),
        ],
      ),
    );
  }
}
