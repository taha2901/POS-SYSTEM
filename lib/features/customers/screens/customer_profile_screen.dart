import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/not_found_state.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/customer_profile_controller.dart';
import '../widgets/customer_profile_tab_bar.dart';
import '../widgets/customer_profile_tab_views.dart';
import '../widgets/customer_summary_card.dart';

/// شاشة ملف العميل — بتجمّع الهيدر وبطاقة الملخّص والتبويبات بس.
class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key, required this.customerId});

  final String customerId;

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen>
    with SingleTickerProviderStateMixin {
  /// الكنترولر محتاج vsync عشان الـTabController اللي جواه.
  late final CustomerProfileController _profile =
      CustomerProfileController(vsync: this);

  @override
  void dispose() {
    _profile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Customer? customer = MockData.customerById(widget.customerId);

    if (customer == null) {
      return NotFoundState(
        icon: Icons.person_off_outlined,
        message: 'لم يتم العثور على العميل',
        onBack: () => context.go('/customers'),
      );
    }

    return ChangeNotifierProvider<CustomerProfileController>.value(
      value: _profile,
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ScreenHeader(
              title: 'ملف العميل',
              subtitle: 'كل تعاملات العميل في مكان واحد',
              leading: BackCircleButton(
                onTap: () => context.go('/customers'),
                tooltip: 'رجوع للعملاء',
              ),
              actions: <Widget>[
                SecondaryButton(
                  label: 'كشف حساب PDF',
                  icon: Icons.picture_as_pdf_outlined,
                  onPressed: () {},
                ),
                PrimaryButton(
                  label: 'تحصيل دفعة',
                  icon: Icons.payments_outlined,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            CustomerSummaryCard(customer: customer),
            const SizedBox(height: AppSpacing.xl),
            const CustomerProfileTabBar(),
            const SizedBox(height: AppSpacing.lg),
            Expanded(child: CustomerProfileTabViews(customer: customer)),
          ],
        ),
      ),
    );
  }
}
