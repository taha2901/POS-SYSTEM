import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/not_found_state.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/supplier_profile_controller.dart';
import '../widgets/supplier_profile_tab_bar.dart';
import '../widgets/supplier_profile_tab_views.dart';
import '../widgets/supplier_summary_card.dart';

/// شاشة ملف المورد — بتجمّع الهيدر وبطاقة الملخّص والتبويبات بس.
class SupplierProfileScreen extends StatefulWidget {
  const SupplierProfileScreen({super.key, required this.supplierId});

  final String supplierId;

  @override
  State<SupplierProfileScreen> createState() => _SupplierProfileScreenState();
}

class _SupplierProfileScreenState extends State<SupplierProfileScreen>
    with SingleTickerProviderStateMixin {
  /// الكنترولر محتاج vsync عشان الـTabController اللي جواه.
  late final SupplierProfileController _profile =
      SupplierProfileController(vsync: this);

  @override
  void dispose() {
    _profile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Supplier? supplier = MockData.supplierById(widget.supplierId);

    if (supplier == null) {
      return NotFoundState(
        icon: Icons.local_shipping_outlined,
        message: 'لم يتم العثور على المورد',
        onBack: () => context.go('/suppliers'),
      );
    }

    return ChangeNotifierProvider<SupplierProfileController>.value(
      value: _profile,
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ScreenHeader(
              title: 'ملف المورد',
              subtitle: 'المنتجات والمستحقات وسجل التوريد',
              leading: BackCircleButton(
                onTap: () => context.go('/suppliers'),
                tooltip: 'رجوع للموردين',
              ),
              actions: <Widget>[
                SecondaryButton(
                  label: 'كشف حساب PDF',
                  icon: Icons.picture_as_pdf_outlined,
                  onPressed: () {},
                ),
                PrimaryButton(
                  label: 'تسجيل دفعة',
                  icon: Icons.payments_outlined,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            SupplierSummaryCard(supplier: supplier),
            const SizedBox(height: AppSpacing.xl),
            const SupplierProfileTabBar(),
            const SizedBox(height: AppSpacing.lg),
            Expanded(child: SupplierProfileTabViews(supplier: supplier)),
          ],
        ),
      ),
    );
  }
}
