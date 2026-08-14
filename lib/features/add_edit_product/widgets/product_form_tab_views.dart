import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/product_form_controller.dart';
import 'barcode_tab.dart';
import 'basic_info_tab.dart';
import 'pricing_tab.dart';
import 'stock_tab.dart';
import 'variants_tab.dart';

/// محتوى التبويبات الخمسة — الترتيب لازم يطابق [ProductFormTab].
class ProductFormTabViews extends StatelessWidget {
  const ProductFormTabViews({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: context.read<ProductFormController>().tabController,
      children: const <Widget>[
        BasicInfoTab(),
        PricingTab(),
        VariantsTab(),
        StockTab(),
        BarcodeTab(),
      ],
    );
  }
}
