import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../theme/app_theme.dart';
import '../controllers/promotions_controller.dart';
import '../widgets/promotions_filter_bar.dart';
import '../widgets/promotions_grid.dart';
import 'create_promotion_dialog.dart';

/// شاشة العروض — بتجمّع شريط الفلترة وشبكة البطاقات بس.
class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  Future<void> _createPromotion(BuildContext context) async {
    final PromotionsController promotions =
        context.read<PromotionsController>();

    final String? name = await showCreatePromotionDialog(context, promotions);
    if (name == null || !context.mounted) return;

    showPlainSnackBar(context, 'تم إنشاء العرض «$name» (تجريبي)', width: 460);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PromotionsController>(
      create: (_) => PromotionsController(),
      child: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: AppSpacing.page,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ScreenHeader(
                  title: 'العروض والخصومات',
                  subtitle: 'إدارة الحملات الترويجية وخصومات نقطة البيع',
                  actions: <Widget>[
                    PrimaryButton(
                      label: 'إنشاء عرض جديد',
                      icon: Icons.add_rounded,
                      onPressed: () => _createPromotion(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                const PromotionsFilterBar(),
                const SizedBox(height: AppSpacing.lg),
                const Expanded(child: PromotionsGrid()),
              ],
            ),
          );
        },
      ),
    );
  }
}
