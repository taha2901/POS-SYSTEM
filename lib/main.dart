import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'features/add_edit_product/screens/add_product_screen.dart';
import 'features/branches/screens/branches_screen.dart';
import 'features/customers/screens/customer_profile_screen.dart';
import 'features/customers/screens/customers_list_screen.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/employees_permissions/screens/employees_list_screen.dart';
import 'features/employees_permissions/screens/roles_permissions_screen.dart';
import 'features/expenses/screens/expenses_screen.dart';
import 'features/inventory/screens/inventory_screen.dart';
import 'features/loyalty/screens/loyalty_screen.dart';
import 'features/pos_sale/screens/pos_sale_screen.dart';
import 'features/products_list/screens/products_list_screen.dart';
import 'features/promotions/screens/promotions_screen.dart';
import 'features/purchase_orders/screens/create_purchase_order_screen.dart';
import 'features/purchase_orders/screens/purchase_orders_screen.dart';
import 'features/returns/screens/returns_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/stock_transfer_stocktake/screens/stocktake_screen.dart';
import 'features/suppliers/screens/supplier_profile_screen.dart';
import 'features/suppliers/screens/suppliers_list_screen.dart';
import 'screens/placeholder_screen.dart';
import 'screens/reports_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/app_shell.dart';

void main() {
  runApp(const PosSystemApp());
}

// ═══════════════════════════════════════════════════════════════════════════
// Router
// ═══════════════════════════════════════════════════════════════════════════

/// كل عناصر القائمة الجانبية ليها شاشة حقيقية دلوقتي.
/// الـPlaceholder اتساب كـfallback للمسارات غير المعروفة بس.
final GoRouter _router = GoRouter(
  initialLocation: '/',
  errorBuilder: (BuildContext context, GoRouterState state) => AppShell(
    child: PlaceholderScreen(
      title: 'الصفحة غير موجودة',
      icon: Icons.explore_off_outlined,
      description: 'المسار «${state.uri.path}» مش موجود — '
          'اختر شاشة من القائمة الجانبية.',
    ),
  ),
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) =>
          AppShell(child: child),
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: WelcomeScreen()),
        ),
        GoRoute(
          path: '/pos',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: PosSaleScreen()),
        ),
        GoRoute(
          path: '/dashboard',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: DashboardScreen()),
        ),
        GoRoute(
          path: '/expenses',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: ExpensesScreen()),
        ),
        GoRoute(
          path: '/branches',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: BranchesScreen()),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: SettingsScreen()),
        ),
        GoRoute(
          path: '/returns',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: ReturnsScreen()),
        ),
        GoRoute(
          path: '/promotions',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: PromotionsScreen()),
        ),
        GoRoute(
          path: '/loyalty',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: LoyaltyScreen()),
        ),
        GoRoute(
          path: '/products',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: ProductsListScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: 'new',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<void>(child: AddProductScreen()),
            ),
          ],
        ),
        GoRoute(
          path: '/inventory',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: InventoryScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: 'stocktake',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<void>(child: StocktakeScreen()),
            ),
          ],
        ),
        GoRoute(
          path: '/purchases',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: PurchaseOrdersScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: 'new',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<void>(
                child: CreatePurchaseOrderScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/customers',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: CustomersListScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: ':id',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  NoTransitionPage<void>(
                child: CustomerProfileScreen(
                  customerId: state.pathParameters['id']!,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/suppliers',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: SuppliersListScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: ':id',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  NoTransitionPage<void>(
                child: SupplierProfileScreen(
                  supplierId: state.pathParameters['id']!,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/employees',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: EmployeesListScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: 'roles',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<void>(
                child: RolesPermissionsScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/reports',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(child: ReportsScreen()),
        ),
      ],
    ),
  ],
);

// ═══════════════════════════════════════════════════════════════════════════
// App
// ═══════════════════════════════════════════════════════════════════════════

class PosSystemApp extends StatelessWidget {
  const PosSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'POS System — نظام إدارة المبيعات',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router,
      locale: const Locale('ar'),
      supportedLocales: const <Locale>[Locale('ar'), Locale('en')],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // اتجاه RTL على مستوى التطبيق كله
      builder: (BuildContext context, Widget? child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// شاشة الترحيب المؤقتة
// ═══════════════════════════════════════════════════════════════════════════

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const List<({String label, IconData icon, String route})> _quickLinks =
      <({String label, IconData icon, String route})>[
    (label: 'نقطة البيع', icon: Icons.point_of_sale_rounded, route: '/pos'),
    (label: 'المنتجات', icon: Icons.inventory_2_outlined, route: '/products'),
    (label: 'التقارير', icon: Icons.bar_chart_rounded, route: '/reports'),
    (label: 'العملاء', icon: Icons.people_alt_outlined, route: '/customers'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.page,
      child: Container(
        width: double.infinity,
        decoration: AppDecorations.card(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: <Color>[AppColors.accent, Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.xl + 4),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.35),
                        blurRadius: 28,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.storefront_rounded,
                    size: 44,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Text(
                  'أهلاً بك في POS System',
                  style: AppText.pageTitle.copyWith(fontSize: 26),
                ),
                const SizedBox(height: AppSpacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Text(
                    'اختر شاشة من القائمة الجانبية للبدء، أو ادخل مباشرةً '
                    'إلى نقطة البيع لتسجيل أول فاتورة.',
                    textAlign: TextAlign.center,
                    style: AppText.body.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 14.5,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                Wrap(
                  spacing: AppSpacing.lg,
                  runSpacing: AppSpacing.lg,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    for (final ({
                      String label,
                      IconData icon,
                      String route
                    }) link in _quickLinks)
                      _QuickLinkCard(
                        label: link.label,
                        icon: link.icon,
                        onTap: () => context.go(link.route),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickLinkCard extends StatefulWidget {
  const _QuickLinkCard({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_QuickLinkCard> createState() => _QuickLinkCardState();
}

class _QuickLinkCardState extends State<_QuickLinkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          width: 148,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lgAll,
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.45)
                  : AppColors.border,
            ),
            boxShadow: _hovered ? AppShadows.lifted : AppShadows.soft,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.accent
                      : AppColors.accent.withValues(alpha: 0.10),
                  borderRadius: AppRadius.mdAll,
                ),
                child: Icon(
                  widget.icon,
                  size: 22,
                  color: _hovered ? Colors.white : AppColors.accent,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: AppText.cardTitle.copyWith(fontSize: 13.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
