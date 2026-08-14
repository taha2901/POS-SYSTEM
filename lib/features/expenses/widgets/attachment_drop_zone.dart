import 'package:flutter/material.dart';

import '../../../core/widgets/dashed_border_painter.dart';
import '../../../theme/app_theme.dart';

/// منطقة رفع مرفق المصروف بحدود متقطعة.
class AttachmentDropZone extends StatefulWidget {
  const AttachmentDropZone({super.key});

  @override
  State<AttachmentDropZone> createState() => _AttachmentDropZoneState();
}

class _AttachmentDropZoneState extends State<AttachmentDropZone> {
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
            radius: AppRadius.md,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            height: 110,
            decoration: BoxDecoration(
              color: _hovered ? AppColors.accentSoft : AppColors.surfaceAlt,
              borderRadius: AppRadius.mdAll,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _hovered
                        ? AppColors.accent
                        : AppColors.accent.withValues(alpha: 0.10),
                    borderRadius: AppRadius.smAll,
                  ),
                  child: Icon(
                    Icons.attach_file_rounded,
                    size: 20,
                    color: _hovered ? Colors.white : AppColors.accent,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'اسحب صورة الفاتورة هنا أو اضغط للاختيار',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.cardTitle.copyWith(fontSize: 13.5),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'PDF أو صورة — حتى 5 ميجابايت',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.caption.copyWith(fontSize: 11.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
