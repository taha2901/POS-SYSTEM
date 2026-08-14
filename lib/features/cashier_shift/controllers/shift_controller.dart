import 'package:flutter/material.dart';

import '../../../core/widgets/numpad.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../models/shift_diff_style.dart';
import '../models/shift_stat.dart';

/// حالة الوردية: الرصيد الافتتاحي عند الفتح، والعدّ الفعلي عند الإغلاق.
class ShiftController extends ChangeNotifier {
  ShiftController({this.openingBalanceOverride});

  /// لو اتمرر، بيحل محل الرصيد الافتتاحي المسجّل في الوردية
  final double? openingBalanceOverride;

  /// مبالغ افتتاحية شائعة للاختيار السريع
  static const List<double> presets = <double>[500, 1000, 2000, 5000];

  /// الرصيد الافتتاحي اللي بيتكتب على الـNumpad
  final AmountEntry _entry = AmountEntry(initial: 2000);

  /// العدّ الفعلي اللي دخّله الكاشير
  final TextEditingController countController = TextEditingController();

  ShiftSummary get shift => MockData.currentShift;

  // ── بدء الوردية ──────────────────────────────────────────────────────────
  String get openingText => _entry.isEmpty ? '0' : _entry.text;

  double get openingValue => _entry.value;

  bool get isOpeningValid => _entry.value > 0;

  bool isPresetSelected(double value) => _entry.value == value;

  void tapKey(String key) {
    _entry.tapKey(key);
    notifyListeners();
  }

  void backspace() {
    _entry.backspace();
    notifyListeners();
  }

  void setOpening(double value) {
    _entry.setValue(value);
    notifyListeners();
  }

  // ── إغلاق الوردية ────────────────────────────────────────────────────────
  double get opening => openingBalanceOverride ?? shift.openingBalance;

  /// المفروض يكون في الدرج
  double get expected =>
      opening + shift.cashSales + shift.cashIn - shift.cashOut;

  double? get actual {
    final String text = countController.text.trim();
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  bool get isCounted => actual != null;

  double get difference => (actual ?? expected) - expected;

  ShiftDiffStyle get diffStyle =>
      ShiftDiffStyle.of(isCounted: isCounted, difference: difference);

  List<ShiftStat> get stats => <ShiftStat>[
        ShiftStat(
          label: 'إجمالي المبيعات',
          value: shift.totalSales,
          icon: Icons.receipt_long_rounded,
          color: AppColors.accent,
        ),
        ShiftStat(
          label: 'كاش',
          value: shift.cashSales,
          icon: Icons.payments_rounded,
          color: AppColors.success,
        ),
        ShiftStat(
          label: 'بطاقة',
          value: shift.cardSales,
          icon: Icons.credit_card_rounded,
          color: AppColors.info,
        ),
        ShiftStat(
          label: 'Cash In',
          value: shift.cashIn,
          icon: Icons.arrow_downward_rounded,
          color: AppColors.success,
        ),
        ShiftStat(
          label: 'Cash Out',
          value: shift.cashOut,
          icon: Icons.arrow_upward_rounded,
          color: AppColors.danger,
        ),
      ];

  /// بيتنده مع كل تعديل في خانة العدّ الفعلي.
  void countChanged([String? _]) => notifyListeners();

  @override
  void dispose() {
    countController.dispose();
    super.dispose();
  }
}
