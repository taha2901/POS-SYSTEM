import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import 'settings_panel.dart';
import 'user_account_row.dart';

/// قسم حسابات المستخدمين.
class UsersSettingsSection extends StatelessWidget {
  const UsersSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Employee> employees = MockData.employees;

    return SettingsPanel(
      children: <Widget>[
        for (int i = 0; i < employees.length; i++)
          UserAccountRow(
            employee: employees[i],
            isLast: i == employees.length - 1,
          ),
      ],
    );
  }
}
