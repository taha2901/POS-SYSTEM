import 'package:flutter/material.dart';

import '../../../core/widgets/dashed_border_painter.dart';
import '../../../theme/app_theme.dart';

/// منطقة رفع صور المنتج بحدود متقطعة.
class ProductImageDropZone extends StatefulWidget {
  const ProductImageDropZone({super.key});

  @override
  State<ProductImageDropZone> createState() => _ProductImageDropZoneState();
}

class _ProductImageDropZoneState extends State<ProductImageDropZone> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {},
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: _hovered ? AppColors.accent : AppColors.borderStrong,
            radius: AppRadius.lg,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            height: 168,
            decoration: BoxDecoration(
              color: _hovered ? AppColors.accentSoft : AppColors.surfaceAlt,
              borderRadius: AppRadius.lgAll,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: _hovered
                        ? AppColors.accent
                        : AppColors.accent.withValues(alpha: 0.10),
                    borderRadius: AppRadius.mdAll,
                  ),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    size: 26,
                    color: _hovered ? Colors.white : AppColors.accent,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'اسحب الصور هنا أو اضغط للاختيار',
                  style: AppText.cardTitle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'PNG أو JPG — الحد الأقصى 2 ميجابايت للصورة',
                  style: AppText.caption.copyWith(fontSize: 11.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
