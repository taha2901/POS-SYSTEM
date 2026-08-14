import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// خلية الدور الوظيفي: أيقونة الدور + اسمه.
class EmployeeRoleCell extends StatelessWidget {
  const EmployeeRoleCell({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final Role? role = MockData.roleById(employee.roleId);

    return Row(
      children: <Widget>[
        Icon(
          role?.icon ?? Icons.person_outline_rounded,
          size: 15,
          color: AppColors.textMuted,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            employee.role,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.body.copyWith(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
