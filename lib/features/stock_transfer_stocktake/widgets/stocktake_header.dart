import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/screen_header.dart';
import '../../../core/widgets/secondary_button.dart';
import '../controllers/stocktake_controller.dart';

/// هيدر شاشة الجرد: العنوان وأزرار التفريغ والمطابقة.
class StocktakeHeader extends StatelessWidget {
  const StocktakeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final StocktakeController stocktake = context.watch<StocktakeController>();

    return ScreenHeader(
      title: 'جرد المخزون',
      subtitle: 'أدخل الكمية الفعلية لكل صنف — الفرق بيتحسب تلقائيًا',
      leading: BackCircleButton(
        onTap: () => context.go('/inventory'),
        tooltip: 'رجوع للمخزون',
      ),
      actions: <Widget>[
        SecondaryButton(
          label: 'تفريغ الإدخالات',
          icon: Icons.restart_alt_rounded,
          onPressed: stocktake.hasCounted ? stocktake.resetAll : null,
        ),
        SecondaryButton(
          label: 'مطابقة النظام',
          icon: Icons.done_all_rounded,
          tone: SecondaryButtonTone.accent,
          onPressed: stocktake.fillAllFromSystem,
        ),
      ],
    );
  }
}
