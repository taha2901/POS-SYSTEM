import 'package:flutter/material.dart';

import '../../../core/widgets/staggered_reveal.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// صف البطاقات الإحصائية الأربعة فوق الجدول.
class InventoryStatCards extends StatefulWidget {
  const InventoryStatCards({super.key});

  @override
  State<InventoryStatCards> createState() => _InventoryStatCardsState();
}

class _InventoryStatCardsState extends State<InventoryStatCards>
    with SingleTickerProviderStateMixin {
  /// أنيميشن الدخول للبطاقات
  late final AnimationController _entryController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 750),
  )..forward();

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = <Widget>[
      StatCard(
        title: 'إجمالي قيمة المخزون',
        value: Fmt.moneyRounded(MockData.inventoryValue),
        icon: Icons.account_balance_wallet_outlined,
        iconColor: AppColors.accent,
        changePercent: 6.4,
      ),
      StatCard(
        title: 'منتجات منخفضة المخزون',
        value: Fmt.count(MockData.lowStockProducts.length),
        icon: Icons.trending_down_rounded,
        iconColor: AppColors.warning,
        changePercent: 12.5,
        higherIsBetter: false,
        changeLabel: 'مقارنة بالأسبوع الماضي',
      ),
      StatCard(
        title: 'منتجات نافدة',
        value: Fmt.count(MockData.outOfStockProducts.length),
        icon: Icons.remove_shopping_cart_outlined,
        iconColor: AppColors.danger,
        changePercent: -25.0,
        higherIsBetter: false,
        changeLabel: 'مقارنة بالأسبوع الماضي',
      ),
      StatCard(
        title: 'قاربت على انتهاء الصلاحية',
        value: Fmt.count(MockData.nearExpiryProducts.length),
        icon: Icons.event_busy_outlined,
        iconColor: AppColors.info,
        changeLabel: 'خلال الـ30 يوم القادمة',
        changePercent: 3.2,
        higherIsBetter: false,
      ),
    ];

    return Row(
      children: <Widget>[
        for (int i = 0; i < cards.length; i++) ...<Widget>[
          Expanded(
            child: StaggeredReveal(
              controller: _entryController,
              index: i,
              // نفس توقيت الأنيميشن الأصلي للبطاقات
              step: 0.12,
              span: 0.55,
              maxStart: 0.6,
              slideFrom: 0.18,
              child: cards[i],
            ),
          ),
          if (i != cards.length - 1) const SizedBox(width: AppSpacing.lg),
        ],
      ],
    );
  }
}
