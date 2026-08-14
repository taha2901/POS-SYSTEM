import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/stocktake_controller.dart';
import 'stocktake_approve_dialog.dart';

/// الشريط السفلي: صافي فرق القيمة وأزرار الحفظ والاعتماد.
class StocktakeFooter extends StatelessWidget {
  const StocktakeFooter({super.key});

  Future<void> _approve(BuildContext context) async {
    final StocktakeController stocktake =
        context.read<StocktakeController>();

    final bool? confirmed =
        await showStocktakeApproveDialog(context, stocktake);
    if (confirmed != true || !context.mounted) return;

    showPlainSnackBar(context, 'تم اعتماد الجرد وترحيل الفروقات (تجريبي)');
    context.go('/inventory');
  }

  @override
  Widget build(BuildContext context) {
    final StocktakeController stocktake = context.watch<StocktakeController>();
    final double netValue = stocktake.netValue;
    final bool hasCounted = stocktake.hasCounted;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x0F0F172A),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'صافي فرق القيمة',
                style: AppText.label.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                Fmt.money(netValue),
                style: AppText.amountHero.copyWith(
                  fontSize: 26,
                  color: netValue < 0
                      ? AppColors.danger
                      : netValue > 0
                          ? AppColors.success
                          : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.xxl),
          Expanded(
            child: Text(
              hasCounted
                  ? 'تم جرد ${Fmt.count(stocktake.countedCount)} صنف من '
                      '${Fmt.count(stocktake.lines.length)}'
                  : 'ابدأ بإدخال الكميات الفعلية للأصناف',
              style: AppText.caption,
            ),
          ),
          SecondaryButton(
            label: 'حفظ كمسودة',
            icon: Icons.save_outlined,
            size: AppButtonSize.large,
            onPressed: hasCounted ? () {} : null,
          ),
          const SizedBox(width: AppSpacing.md),
          PrimaryButton(
            label: 'اعتماد الجرد',
            icon: Icons.fact_check_outlined,
            size: AppButtonSize.large,
            onPressed: hasCounted ? () => _approve(context) : null,
          ),
        ],
      ),
    );
  }
}
