import 'package:flutter/material.dart';

import '../../../core/widgets/hover_row_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// زرار «استلام» أو «عرض» حسب حالة الأمر.
class PurchaseOrderRowAction extends StatelessWidget {
  const PurchaseOrderRowAction({
    super.key,
    required this.order,
    required this.hovered,
    required this.onPressed,
  });

  final PurchaseOrder order;
  final bool hovered;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return HoverRowButton(
      label: order.isReceivable ? 'استلام' : 'عرض',
      color: order.isReceivable ? AppColors.success : AppColors.primary,
      hovered: hovered,
      onPressed: onPressed,
    );
  }
}
