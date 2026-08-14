import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../controllers/roles_permissions_controller.dart';

/// الشريط السفلي الثابت: حالة الحفظ وأزرار الاستعادة والحفظ.
class RolesPermissionsFooter extends StatelessWidget {
  const RolesPermissionsFooter({super.key});

  void _save(BuildContext context) {
    final RolesPermissionsController roles =
        context.read<RolesPermissionsController>();
    final String roleName = roles.role.name;

    roles.save();
    showPlainSnackBar(
      context,
      'تم حفظ صلاحيات دور «$roleName» (تجريبي)',
      width: 460,
    );
  }

  @override
  Widget build(BuildContext context) {
    final RolesPermissionsController roles =
        context.watch<RolesPermissionsController>();
    final bool dirty = roles.dirty;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x0F0F172A),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            dirty
                ? Icons.edit_note_rounded
                : Icons.check_circle_outline_rounded,
            size: 18,
            color: dirty ? AppColors.warning : AppColors.success,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              dirty
                  ? 'يوجد تغييرات غير محفوظة على دور «${roles.role.name}»'
                  : 'كل التغييرات محفوظة',
              style: AppText.caption.copyWith(fontSize: 12.5),
            ),
          ),
          SecondaryButton(
            label: 'استعادة الافتراضي',
            icon: Icons.restart_alt_rounded,
            size: AppButtonSize.large,
            onPressed: dirty ? roles.reset : null,
          ),
          const SizedBox(width: AppSpacing.md),
          PrimaryButton(
            label: 'حفظ التغييرات',
            icon: Icons.save_outlined,
            size: AppButtonSize.large,
            onPressed: dirty ? () => _save(context) : null,
          ),
        ],
      ),
    );
  }
}
