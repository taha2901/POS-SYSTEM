import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_form_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/product_form_controller.dart';
import '../models/product_variant.dart';
import 'form_hint_row.dart';
import 'product_form_tab_card.dart';
import 'variant_row.dart';
import 'variants_table_header.dart';

/// التبويب التالت: مقاسات وألوان نفس المنتج.
class VariantsTab extends StatelessWidget {
  const VariantsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductFormController form = context.watch<ProductFormController>();
    final List<ProductVariant> variants = form.variants;

    return ProductFormTabCard(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(
              child: FormSectionTitle(
                title: 'متغيرات المنتج',
                subtitle: 'المقاسات والألوان المختلفة لنفس المنتج',
                icon: Icons.tune_rounded,
              ),
            ),
            SecondaryButton(
              label: 'صف جديد',
              icon: Icons.add_rounded,
              size: AppButtonSize.small,
              tone: SecondaryButtonTone.accent,
              onPressed: form.addVariant,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        const VariantsTableHeader(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(AppRadius.md),
            ),
          ),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < variants.length; i++)
                VariantRow(
                  key: ObjectKey(variants[i]),
                  variant: variants[i],
                  isLast: i == variants.length - 1,
                  canRemove: variants.length > 1,
                  onRemove: () => form.removeVariantAt(i),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const FormHintRow(
          icon: Icons.lightbulb_outline_rounded,
          text: 'سيب التبويب فاضي لو المنتج مالوش متغيرات (مقاسات أو ألوان).',
        ),
      ],
    );
  }
}
