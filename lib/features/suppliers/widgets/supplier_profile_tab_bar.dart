import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_tab_bar.dart';
import '../../../core/widgets/icon_tab_label.dart';
import '../controllers/supplier_profile_controller.dart';
import '../models/supplier_profile_tab.dart';

/// شريط تبويبات ملف المورد.
class SupplierProfileTabBar extends StatelessWidget {
  const SupplierProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTabBar(
      controller: context.read<SupplierProfileController>().tabController,
      tabs: <Widget>[
        for (final SupplierProfileTab tab in SupplierProfileTab.values)
          IconTabLabel(icon: tab.icon, label: tab.label),
      ],
    );
  }
}
