import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/roles_permissions_controller.dart';
import 'permission_group_header.dart';
import 'permission_row.dart';

/// بطاقة قسم صلاحيات واحد (المبيعات، المخزون، المشتريات…).
class PermissionGroupCard extends StatelessWidget {
  const PermissionGroupCard({super.key, required this.group});

  final PermissionGroup group;

  @override
  Widget build(BuildContext context) {
    final RolesPermissionsController roles =
        context.watch<RolesPermissionsController>();

    return Container(
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PermissionGroupHeader(group: group),
          for (int i = 0; i < group.permissions.length; i++)
            PermissionRow(
              permission: group.permissions[i],
              value: roles.isEnabled(group.permissions[i].id),
              isLast: i == group.permissions.length - 1,
              onChanged: (bool v) =>
                  roles.toggle(group.permissions[i].id, v),
            ),
        ],
      ),
    );
  }
}
