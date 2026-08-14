import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/screen_header.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/roles_permissions_controller.dart';
import '../widgets/permissions_area.dart';
import '../widgets/roles_list_panel.dart';
import '../widgets/roles_permissions_footer.dart';

/// شاشة الأدوار والصلاحيات — بتجمّع قائمة الأدوار ومنطقة الصلاحيات والفوتر.
class RolesPermissionsScreen extends StatefulWidget {
  const RolesPermissionsScreen({super.key});

  @override
  State<RolesPermissionsScreen> createState() => _RolesPermissionsScreenState();
}

class _RolesPermissionsScreenState extends State<RolesPermissionsScreen>
    with SingleTickerProviderStateMixin {
  /// الكنترولر محتاج vsync عشان أنيميشن الـFade عند تبديل الدور.
  late final RolesPermissionsController _roles =
      RolesPermissionsController(vsync: this);

  @override
  void dispose() {
    _roles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RolesPermissionsController>.value(
      value: _roles,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xxl,
                AppSpacing.xxl,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ScreenHeader(
                    title: 'الأدوار والصلاحيات',
                    subtitle:
                        'اختر دورًا من القائمة وتحكّم في صلاحياته داخل النظام',
                    leading: BackCircleButton(
                      onTap: () => context.go('/employees'),
                      tooltip: 'رجوع للموظفين',
                    ),
                    actions: <Widget>[
                      SecondaryButton(
                        label: 'دور جديد',
                        icon: Icons.add_moderator_outlined,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // عمود الأدوار (يمين في RTL)
                        SizedBox(width: 288, child: RolesListPanel()),
                        SizedBox(width: AppSpacing.xl),
                        Expanded(child: PermissionsArea()),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
          const RolesPermissionsFooter(),
        ],
      ),
    );
  }
}
