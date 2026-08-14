import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/shift_controller.dart';
import '../widgets/close_shift_footer.dart';
import '../widgets/close_shift_header.dart';
import '../widgets/shift_count_field.dart';
import '../widgets/shift_difference_card.dart';
import '../widgets/shift_stat_cards.dart';

/// يفتح حوار إغلاق الوردية ويرجّع true لو اتقفلت فعلاً.
Future<bool?> showCloseShiftDialog(
  BuildContext context, {
  double? openingBalance,
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: AppColors.primary.withValues(alpha: 0.55),
    builder: (BuildContext context) => CloseShiftDialog(
      openingBalance: openingBalance,
    ),
  );
}

/// حوار إغلاق الوردية — بيجمّع الهيدر والإحصائيات وحقل العدّ وبطاقة الفرق.
class CloseShiftDialog extends StatelessWidget {
  const CloseShiftDialog({super.key, this.openingBalance});

  /// لو اتمرر، بيحل محل الرصيد الافتتاحي المسجّل في الوردية
  final double? openingBalance;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.sizeOf(context);

    return ChangeNotifierProvider<ShiftController>(
      create: (_) => ShiftController(openingBalanceOverride: openingBalance),
      child: Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.xxl),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 860,
            maxHeight: screen.height - 80,
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CloseShiftHeader(),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.xxl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ShiftStatCards(),
                      SizedBox(height: AppSpacing.xl),
                      ShiftCountField(),
                      SizedBox(height: AppSpacing.lg),
                      ShiftDifferenceCard(),
                    ],
                  ),
                ),
              ),
              CloseShiftFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
