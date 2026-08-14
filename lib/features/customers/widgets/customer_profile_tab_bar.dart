import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_tab_bar.dart';
import '../../../core/widgets/icon_tab_label.dart';
import '../controllers/customer_profile_controller.dart';
import '../models/customer_profile_tab.dart';

/// شريط تبويبات ملف العميل.
class CustomerProfileTabBar extends StatelessWidget {
  const CustomerProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTabBar(
      controller: context.read<CustomerProfileController>().tabController,
      tabs: <Widget>[
        for (final CustomerProfileTab tab in CustomerProfileTab.values)
          IconTabLabel(icon: tab.icon, label: tab.label),
      ],
    );
  }
}
