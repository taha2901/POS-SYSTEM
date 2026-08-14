import 'package:flutter/material.dart';

import '../models/customer_profile_tab.dart';

/// حالة ملف العميل: التبويب المفتوح.
class CustomerProfileController extends ChangeNotifier {
  CustomerProfileController({required TickerProvider vsync}) {
    tabController = TabController(
      length: CustomerProfileTab.values.length,
      vsync: vsync,
    )..addListener(() {
        if (tabController.indexIsChanging) notifyListeners();
      });
  }

  late final TabController tabController;

  int get currentTabIndex => tabController.index;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
