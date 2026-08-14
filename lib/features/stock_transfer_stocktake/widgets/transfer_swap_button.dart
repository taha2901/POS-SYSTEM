import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// زرار عكس اتجاه التحويل بين الفرعين.
class TransferSwapButton extends StatelessWidget {
  const TransferSwapButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'عكس الاتجاه',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: AppRadius.mdAll,
              boxShadow: AppShadows.soft,
            ),
            child: const Icon(
              // في RTL السهم لليسار يعني "من اليمين إلى اليسار"
              Icons.arrow_back_rounded,
              size: 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
