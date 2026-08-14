import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/stat_card.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/purchase_orders_controller.dart';

/// البطاقات الإحصائية الأربعة فوق جدول الأوامر.
class PurchaseOrdersStatCards extends StatelessWidget {
  const PurchaseOrdersStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchaseOrdersController orders =
        context.watch<PurchaseOrdersController>();

    return Row(
      children: <Widget>[
        Expanded(
          child: StatCard(
            title: 'أوامر بانتظار الاستلام',
            value: Fmt.count(orders.awaitingCount),
            icon: Icons.local_shipping_outlined,
            iconColor: AppColors.info,
            changeLabel: 'متابعة يومية',
            changePercent: 8.3,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'قيمة الأوامر المعلّقة',
            value: Fmt.moneyRounded(orders.pendingValue),
            icon: Icons.account_balance_wallet_outlined,
            iconColor: AppColors.accent,
            changeLabel: 'مقارنة بالشهر الماضي',
            changePercent: 14.2,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'مسودات لم تُعتمد',
            value: Fmt.count(
              orders.countByStatus(PurchaseOrderStatus.draft),
            ),
            icon: Icons.edit_note_rounded,
            iconColor: AppColors.warning,
            higherIsBetter: false,
            changeLabel: 'تحتاج مراجعة',
            changePercent: -12.0,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            title: 'أوامر مكتملة',
            value: Fmt.count(
              orders.countByStatus(PurchaseOrderStatus.completed),
            ),
            icon: Icons.task_alt_rounded,
            iconColor: AppColors.success,
            changeLabel: 'خلال 30 يوم',
            changePercent: 22.5,
          ),
        ),
      ],
    );
  }
}
