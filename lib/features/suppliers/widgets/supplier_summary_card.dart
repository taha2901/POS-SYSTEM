import 'package:flutter/material.dart';

import '../../../core/widgets/profile_summary_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// بطاقة ملخّص المورد أعلى الملف.
class SupplierSummaryCard extends StatelessWidget {
  const SupplierSummaryCard({super.key, required this.supplier});

  final Supplier supplier;

  @override
  Widget build(BuildContext context) {
    final Supplier s = supplier;
    final bool hasDue = s.balanceDue > 0;
    final int productsCount = MockData.productsBySupplier(s.id).length;

    return ProfileSummaryCard(
      name: s.name,
      subtitle: 'مسؤول التواصل: ${s.contactPerson}',
      avatarIcon: Icons.storefront_rounded,
      avatarColor: AppColors.accent,
      badge: StatusBadge(
        label: s.isActive ? 'نشط' : 'موقوف',
        tone: s.isActive ? StatusTone.success : StatusTone.neutral,
      ),
      meta: <(IconData, String)>[
        (Icons.phone_outlined, s.phone),
        (Icons.mail_outline_rounded, s.email),
        (Icons.inventory_2_outlined, '$productsCount صنف موّرد'),
      ],
      stats: <ProfileStat>[
        ProfileStat(
          label: 'الرصيد المستحق للمورد',
          value: Fmt.money(s.balanceDue),
          color: hasDue ? AppColors.danger : AppColors.success,
          icon: Icons.account_balance_wallet_outlined,
          big: true,
        ),
        ProfileStat(
          label: 'أوامر التوريد',
          value: Fmt.count(s.ordersCount),
          icon: Icons.receipt_long_outlined,
        ),
        ProfileStat(
          label: 'إجمالي المشتريات',
          value: Fmt.moneyRounded(s.totalPurchases),
          icon: Icons.shopping_cart_outlined,
        ),
        ProfileStat(
          label: 'متوسط الأمر',
          value: Fmt.moneyRounded(
            s.ordersCount == 0 ? 0 : s.totalPurchases / s.ordersCount,
          ),
          icon: Icons.equalizer_rounded,
        ),
      ],
    );
  }
}
