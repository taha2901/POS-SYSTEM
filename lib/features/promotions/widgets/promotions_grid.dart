import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/promotions_controller.dart';
import 'promotion_card.dart';
import 'promotions_empty_state.dart';

/// شبكة بطاقات العروض.
class PromotionsGrid extends StatelessWidget {
  const PromotionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Promotion> rows = context.watch<PromotionsController>().rows;

    if (rows.isEmpty) return const PromotionsEmptyState();

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 224,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
      ),
      itemCount: rows.length,
      itemBuilder: (BuildContext context, int i) =>
          PromotionCard(promotion: rows[i]),
    );
  }
}
