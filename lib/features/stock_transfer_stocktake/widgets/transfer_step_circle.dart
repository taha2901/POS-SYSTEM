import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../models/transfer_status.dart';

/// دائرة مرحلة واحدة في شريط التقدّم.
class TransferStepCircle extends StatelessWidget {
  const TransferStepCircle({
    super.key,
    required this.status,
    required this.index,
    required this.currentIndex,
  });

  final TransferStatus status;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final bool done = index < currentIndex;
    final bool active = index == currentIndex;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: done
                ? AppColors.accent
                : active
                    ? AppColors.accentSoft
                    : AppColors.surfaceAlt,
            shape: BoxShape.circle,
            border: Border.all(
              color: active || done ? AppColors.accent : AppColors.border,
              width: active ? 2 : 1,
            ),
          ),
          child: Icon(
            done ? Icons.check_rounded : status.icon,
            size: 16,
            color: done
                ? Colors.white
                : active
                    ? AppColors.accent
                    : AppColors.textMuted,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          status.label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active
                ? AppColors.accent
                : done
                    ? AppColors.textPrimary
                    : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
