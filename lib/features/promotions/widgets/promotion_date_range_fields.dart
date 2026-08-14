import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/promotions_controller.dart';
import 'promotion_date_field.dart';

/// حقلا البداية والنهاية + مدة العرض.
class PromotionDateRangeFields extends StatelessWidget {
  const PromotionDateRangeFields({super.key});

  /// نفس ثيم منتقي التاريخ المستخدم في باقي النظام.
  Future<void> _pickDate(
    BuildContext context, {
    required bool isStart,
  }) async {
    final PromotionsController promotions =
        context.read<PromotionsController>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? promotions.start : promotions.end,
      firstDate: MockData.today.subtract(const Duration(days: 365)),
      lastDate: MockData.today.add(const Duration(days: 730)),
      locale: const Locale('ar'),
      builder: (BuildContext context, Widget? child) => Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            backgroundColor: AppColors.surface,
            surfaceTintColor: Colors.transparent,
            headerBackgroundColor: AppColors.primary,
            headerForegroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            todayBorder: const BorderSide(color: AppColors.accent),
          ),
        ),
        child: child!,
      ),
    );

    if (picked == null) return;

    if (isStart) {
      promotions.setStart(picked);
    } else {
      promotions.setEnd(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PromotionsController promotions =
        context.watch<PromotionsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: PromotionDateField(
                label: 'تاريخ البداية',
                date: promotions.start,
                onTap: () => _pickDate(context, isStart: true),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: PromotionDateField(
                label: 'تاريخ النهاية',
                date: promotions.end,
                onTap: () => _pickDate(context, isStart: false),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: <Widget>[
            const Icon(
              Icons.schedule_rounded,
              size: 14,
              color: AppColors.textMuted,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'مدة العرض: ${promotions.durationDays} يوم',
              style: AppText.caption.copyWith(fontSize: 11.5),
            ),
          ],
        ),
      ],
    );
  }
}
