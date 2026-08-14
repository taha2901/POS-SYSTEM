import 'package:flutter/material.dart';

import '../models/supplier_profile_tab.dart';

/// حالة ملف المورد: التبويب المفتوح.
class SupplierProfileController extends ChangeNotifier {
  SupplierProfileController({required TickerProvider vsync}) {
    tabController = TabController(
      length: SupplierProfileTab.values.length,
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
