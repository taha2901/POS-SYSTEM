import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_form_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/product_form_controller.dart';
import 'barcode_preview.dart';
import 'product_form_tab_card.dart';

/// التبويب الخامس: باركود المنتج وتوليده وطباعته.
class BarcodeTab extends StatelessWidget {
  const BarcodeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductFormController form = context.read<ProductFormController>();

    return ProductFormTabCard(
      children: <Widget>[
        const FormSectionTitle(
          title: 'الباركود',
          subtitle: 'كود المنتج المستخدم في المسح السريع على الكاشير',
          icon: Icons.qr_code_2_rounded,
        ),
        const SizedBox(height: AppSpacing.xl),
        const Center(child: BarcodePreview()),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SecondaryButton(
                label: 'طباعة الملصق',
                icon: Icons.print_outlined,
                onPressed: () {},
              ),
              const SizedBox(width: AppSpacing.md),
              PrimaryButton(
                label: 'توليد باركود جديد',
                icon: Icons.autorenew_rounded,
                onPressed: form.generateBarcode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
