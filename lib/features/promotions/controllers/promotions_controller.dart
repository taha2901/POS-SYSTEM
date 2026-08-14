import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';

/// حالة شاشة العروض: فلاتر القائمة + نموذج إنشاء عرض جديد.
class PromotionsController extends ChangeNotifier {
  // ── فلاتر القائمة ────────────────────────────────────────────────────────
  PromotionStatus? _statusFilter;
  PromotionType? _typeFilter;

  PromotionStatus? get statusFilter => _statusFilter;
  PromotionType? get typeFilter => _typeFilter;

  List<Promotion> get rows => MockData.promotions.where((Promotion p) {
        if (_statusFilter != null && p.status != _statusFilter) return false;
        if (_typeFilter != null && p.type != _typeFilter) return false;
        return true;
      }).toList(growable: false);

  int get visibleCount => rows.length;

  int countByStatus(PromotionStatus status) =>
      MockData.promotions.where((Promotion p) => p.status == status).length;

  /// الضغط على نفس الشريحة تاني بيلغي الفلتر.
  void toggleStatusFilter(PromotionStatus status) {
    _statusFilter = _statusFilter == status ? null : status;
    notifyListeners();
  }

  void setTypeFilter(PromotionType? type) {
    _typeFilter = type;
    notifyListeners();
  }

  // ── نموذج الإنشاء ────────────────────────────────────────────────────────
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  PromotionType _formType = PromotionType.percentage;
  DateTime _start = MockData.today;
  DateTime _end = MockData.today.add(const Duration(days: 30));

  PromotionType get formType => _formType;
  DateTime get start => _start;
  DateTime get end => _end;

  int get durationDays => _end.difference(_start).inDays;

  String get promotionName => nameController.text.trim();

  bool get isFormValid =>
      promotionName.isNotEmpty &&
      valueController.text.trim().isNotEmpty &&
      _end.isAfter(_start);

  /// بيرجّع النموذج لحالته الأولى قبل كل فتح للحوار.
  void resetForm() {
    nameController.clear();
    valueController.clear();
    _formType = PromotionType.percentage;
    _start = MockData.today;
    _end = MockData.today.add(const Duration(days: 30));
  }

  void setFormType(PromotionType type) {
    _formType = type;
    notifyListeners();
  }

  void setStart(DateTime date) {
    _start = date;
    // النهاية لازم تفضل بعد البداية
    if (!_end.isAfter(_start)) {
      _end = _start.add(const Duration(days: 30));
    }
    notifyListeners();
  }

  void setEnd(DateTime date) {
    _end = date;
    notifyListeners();
  }

  /// أي تعديل في حقول النص بيعيد تقييم صلاحية النموذج.
  void formFieldChanged([String? _]) => notifyListeners();

  @override
  void dispose() {
    nameController.dispose();
    valueController.dispose();
    super.dispose();
  }
}
