import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../mock_data/mock_data.dart';
import '../../../utils/formatters.dart';
import '../controllers/employees_list_controller.dart';

/// فلتر الدور الوظيفي.
class EmployeesRoleDropdown extends StatelessWidget {
  const EmployeesRoleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeesListController employees =
        context.watch<EmployeesListController>();

    return AppDropdown<String?>(
      value: employees.roleId,
      width: 180,
      icon: Icons.shield_outlined,
      onChanged: employees.setRole,
      items: <AppDropdownItem<String?>>[
        const AppDropdownItem<String?>(
          value: null,
          label: 'كل الأدوار',
          icon: Icons.apps_rounded,
        ),
        for (final Role r in MockData.roles)
          AppDropdownItem<String?>(
            value: r.id,
            label: r.name,
            icon: r.icon,
            trailing: Fmt.count(r.employeesCount),
          ),
      ],
    );
  }
}
