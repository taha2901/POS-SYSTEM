import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/cart_controller.dart';
import '../controllers/sales_session_controller.dart';
import '../widgets/cart_panel.dart';
import '../widgets/products_panel.dart';

/// شاشة نقطة البيع — بتجمّع لوحة المنتجات ولوحة السلة بس.
///
/// الفواتير المفتوحة كلها في [SalesSessionController]، والشاشة بتوفّر
/// الفاتورة النشطة بس كـ[CartController] عشان باقي الويدجتس ما تحتاجش تعرف
/// إن فيه تبويبات أصلاً.
class PosSaleScreen extends StatelessWidget {
  const PosSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SalesSessionController>(
      create: (_) => SalesSessionController(),
      child: Consumer<SalesSessionController>(
        builder: (
          BuildContext context,
          SalesSessionController session,
          Widget? child,
        ) {
          return ChangeNotifierProvider<CartController>.value(
            value: session.active,
            child: child!,
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(AppSpacing.xxl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // المنتجات — الجزء الأكبر (يمين في RTL)
              Expanded(flex: 2, child: ProductsPanel()),
              SizedBox(width: AppSpacing.xl),
              // السلة — الجزء الأصغر (يسار في RTL)
              Expanded(child: CartPanel()),
            ],
          ),
        ),
      ),
    );
  }
}
