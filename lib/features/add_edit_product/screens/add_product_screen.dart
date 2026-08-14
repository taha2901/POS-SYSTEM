import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/product_form_controller.dart';
import '../widgets/add_product_footer.dart';
import '../widgets/add_product_header.dart';
import '../widgets/product_form_tab_bar.dart';
import '../widgets/product_form_tab_views.dart';

/// شاشة إضافة/تعديل منتج — بتجمّع الهيدر والتبويبات والشريط السفلي بس.
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with SingleTickerProviderStateMixin {
  /// الكنترولر محتاج vsync عشان الـTabController اللي جواه.
  late final ProductFormController _form = ProductFormController(vsync: this);

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductFormController>.value(
      value: _form,
      child: const Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xxl,
                AppSpacing.xxl,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AddProductHeader(),
                  SizedBox(height: AppSpacing.xl),
                  ProductFormTabBar(),
                  SizedBox(height: AppSpacing.lg),
                  Expanded(child: ProductFormTabViews()),
                ],
              ),
            ),
          ),
          AddProductFooter(),
        ],
      ),
    );
  }
}
