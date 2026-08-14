import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/product_form_controller.dart';
import 'barcode_painter.dart';

/// معاينة الباركود مع رقمه تحته.
class BarcodePreview extends StatelessWidget {
  const BarcodePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final String barcode =
        context.select((ProductFormController f) => f.barcode);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 300,
            height: 96,
            child: CustomPaint(
              painter: BarcodePainter(seed: barcode),
              size: const Size(300, 96),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            barcode,
            style: AppText.amountMd.copyWith(fontSize: 17, letterSpacing: 4),
          ),
        ],
      ),
    );
  }
}
