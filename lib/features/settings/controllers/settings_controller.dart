import 'package:flutter/material.dart';

import '../models/settings_section.dart';

/// حالة شاشة الإعدادات: القسم المختار وكل قيم الإعدادات.
class SettingsController extends ChangeNotifier {
  SettingsController({required TickerProvider vsync}) {
    fadeController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
      value: 1,
    );
  }

  /// أنيميشن الـFade عند تبديل القسم
  late final AnimationController fadeController;

  SettingsSection _section = SettingsSection.general;
  SettingsSection get section => _section;

  // ── إعدادات عامة ─────────────────────────────────────────────────────────
  final TextEditingController storeNameController =
      TextEditingController(text: 'POS System — متجر المعادي');
  String _currency = 'الجنيه المصري (ج.م)';
  String get currency => _currency;

  // ── الضرائب ──────────────────────────────────────────────────────────────
  final TextEditingController taxRateController =
      TextEditingController(text: '14');
  final TextEditingController taxNumberController =
      TextEditingController(text: '512-874-336');
  bool _taxIncluded = true;
  bool get taxIncluded => _taxIncluded;

  double get taxRate => double.tryParse(taxRateController.text.trim()) ?? 0;

  // ── الطباعة ──────────────────────────────────────────────────────────────
  final TextEditingController footerNoteController = TextEditingController(
    text: 'شكرًا لتسوقك معنا — نتشرف بخدمتك دائمًا',
  );
  bool _printAuto = true;
  bool _printLogo = true;
  bool get printAuto => _printAuto;
  bool get printLogo => _printLogo;

  // ── الإشعارات ────────────────────────────────────────────────────────────
  bool _notifyLowStock = true;
  bool _notifyDailyReport = true;
  bool _notifyShiftClose = false;
  bool get notifyLowStock => _notifyLowStock;
  bool get notifyDailyReport => _notifyDailyReport;
  bool get notifyShiftClose => _notifyShiftClose;

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void selectSection(SettingsSection section) {
    if (section == _section) return;

    _section = section;
    fadeController
      ..reset()
      ..forward();
    notifyListeners();
  }

  void setCurrency(String currency) {
    _currency = currency;
    notifyListeners();
  }

  void setTaxIncluded(bool value) {
    _taxIncluded = value;
    notifyListeners();
  }

  void setPrintAuto(bool value) {
    _printAuto = value;
    notifyListeners();
  }

  void setPrintLogo(bool value) {
    _printLogo = value;
    notifyListeners();
  }

  void setNotifyLowStock(bool value) {
    _notifyLowStock = value;
    notifyListeners();
  }

  void setNotifyDailyReport(bool value) {
    _notifyDailyReport = value;
    notifyListeners();
  }

  void setNotifyShiftClose(bool value) {
    _notifyShiftClose = value;
    notifyListeners();
  }

  /// أي تعديل في حقول النص اللي ليها معاينة حيّة.
  void fieldChanged([String? _]) => notifyListeners();

  @override
  void dispose() {
    fadeController.dispose();
    storeNameController.dispose();
    taxRateController.dispose();
    taxNumberController.dispose();
    footerNoteController.dispose();
    super.dispose();
  }
}
