import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_tab_bar.dart';
import '../controllers/product_form_controller.dart';
import '../models/product_form_tab.dart';
import 'product_form_tab_label.dart';

/// شريط تبويبات النموذج.
class ProductFormTabBar extends StatelessWidget {
  const ProductFormTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductFormController form = context.watch<ProductFormController>();

    return AppTabBar(
      controller: form.tabController,
      tabs: <Widget>[
        for (final ProductFormTab tab in ProductFormTab.values)
          ProductFormTabLabel(
            number: tab.index + 1,
            label: tab.label,
            selected: form.currentTabIndex == tab.index,
          ),
      ],
    );
  }
}
