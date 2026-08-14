import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/screen_header.dart';
import '../../../theme/app_theme.dart';
import '../controllers/create_purchase_order_controller.dart';
import '../widgets/create_po_lines_card.dart';
import '../widgets/create_po_supplier_card.dart';
import '../widgets/create_po_totals_bar.dart';

/// شاشة أمر شراء جديد — بتجمّع الهيدر وبطاقة المورد وجدول الأصناف والإجماليات.
class CreatePurchaseOrderScreen extends StatelessWidget {
  const CreatePurchaseOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreatePurchaseOrderController>(
      create: (_) => CreatePurchaseOrderController(),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xxl,
                AppSpacing.xxl,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ScreenHeader(
                    title: 'أمر شراء جديد',
                    subtitle: 'اختر المورد وأضف الأصناف المطلوب توريدها',
                    leading: BackCircleButton(
                      onTap: () => context.go('/purchases'),
                      tooltip: 'رجوع لأوامر الشراء',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const CreatePoSupplierCard(),
                  const SizedBox(height: AppSpacing.xl),
                  const Expanded(child: CreatePoLinesCard()),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
          const CreatePoTotalsBar(),
        ],
      ),
    );
  }
}
