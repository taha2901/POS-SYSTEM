import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';

/// حالة شاشة الأدوار: الدور المختار وصلاحياته وهل فيه تغييرات غير محفوظة.
class RolesPermissionsController extends ChangeNotifier {
  RolesPermissionsController({required TickerProvider vsync}) {
    fadeController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 320),
      value: 1,
    );
  }

  /// نسخة قابلة للتعديل من صلاحيات كل دور
  final Map<String, Set<String>> _permissions = <String, Set<String>>{
    for (final MapEntry<String, Set<String>> e
        in MockData.rolePermissions.entries)
      e.key: Set<String>.from(e.value),
  };

  String _selectedRoleId = MockData.roles.first.id;
  bool _dirty = false;

  /// أنيميشن الـFade عند تبديل الدور
  late final AnimationController fadeController;

  String get selectedRoleId => _selectedRoleId;
  bool get dirty => _dirty;

  Role get role => MockData.roleById(_selectedRoleId)!;

  Set<String> get _current => _permissions[_selectedRoleId]!;

  int get enabledCount => _current.length;

  int get totalPermissions => MockData.permissionGroups
      .fold<int>(0, (int s, PermissionGroup g) => s + g.permissions.length);

  bool isEnabled(String permissionId) => _current.contains(permissionId);

  int enabledCountForRole(String roleId) =>
      _permissions[roleId]?.length ?? 0;

  int enabledCountIn(PermissionGroup group) => group.permissions
      .where((Permission p) => _current.contains(p.id))
      .length;

  bool isGroupAllOn(PermissionGroup group) =>
      enabledCountIn(group) == group.permissions.length;

  // ── إجراءات ──────────────────────────────────────────────────────────────
  void selectRole(String roleId) {
    if (roleId == _selectedRoleId) return;

    _selectedRoleId = roleId;
    fadeController
      ..reset()
      ..forward();
    notifyListeners();
  }

  void toggle(String permissionId, bool value) {
    if (value) {
      _current.add(permissionId);
    } else {
      _current.remove(permissionId);
    }
    _dirty = true;
    notifyListeners();
  }

  void toggleGroup(PermissionGroup group, bool value) {
    for (final Permission p in group.permissions) {
      if (value) {
        _current.add(p.id);
      } else {
        _current.remove(p.id);
      }
    }
    _dirty = true;
    notifyListeners();
  }

  void save() {
    _dirty = false;
    notifyListeners();
  }

  /// يرجّع صلاحيات الدور للقيم الافتراضية.
  void reset() {
    _permissions[_selectedRoleId] = Set<String>.from(
      MockData.rolePermissions[_selectedRoleId] ?? <String>{},
    );
    _dirty = false;
    notifyListeners();
  }

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
  }
}
