import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../theme/app_theme.dart';
import '../controllers/loyalty_controller.dart';
import '../widgets/loyalty_earning_section.dart';
import '../widgets/loyalty_leaderboard.dart';
import '../widgets/loyalty_tiers_section.dart';

/// شاشة برنامج الولاء — بتجمّع إعداد الكسب والمستويات وجدول الترتيب بس.
class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({super.key});

  void _save(BuildContext context) {
    final LoyaltyController loyalty = context.read<LoyaltyController>();

    showPlainSnackBar(
      context,
      'تم حفظ آلية الكسب: ${loyalty.rate} نقطة لكل جنيه (تجريبي)',
      width: 460,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoyaltyController>(
      create: (_) => LoyaltyController(),
      child: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: AppSpacing.page,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ScreenHeader(
                    title: 'برنامج الولاء',
                    subtitle:
                        'إعدادات كسب النقاط ومستويات العضوية وأعلى العملاء',
                    actions: <Widget>[
                      PrimaryButton(
                        label: 'حفظ الإعدادات',
                        icon: Icons.save_outlined,
                        onPressed: () => _save(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const LoyaltyEarningSection(),
                  const SizedBox(height: AppSpacing.xxl),
                  const LoyaltyTiersSection(),
                  const SizedBox(height: AppSpacing.xxl),
                  const LoyaltyLeaderboard(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
