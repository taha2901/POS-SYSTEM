# تقدّم الريفاكتور — من `lib/screens/` لـ `lib/features/`

**الحالة: كل الـ18 feature المطلوبة خلصت ✅**

كل feature اتنقلت لـ `lib/features/<name>/{models,controllers,screens,widgets}/`،
الحالة بـ`ChangeNotifier` + `provider`، وكل جزء بصري في ملف Widget مستقل
(مفيش `_buildSomething()` بترجع Widget جوه ملف الشاشة، وملف = Widget عام واحد).
الملفات القديمة اتمسحت نهائيًا بعد ما `flutter analyze` و`flutter test` و`flutter build` عدّوا.

## الـ18 feature

| # | Feature | الملفات القديمة (اتمسحت) | المكان الجديد | الـControllers | الحالة |
|---|---------|--------------------------|----------------|----------------|--------|
| 1 | pos_sale | `pos_sale_screen.dart` (51KB) | `features/pos_sale/` — 29 ملف | `CartController` | ✅ خلص |
| 2 | payment | `payment_dialog.dart` (33KB) | `features/payment/` — 22 ملف | `PaymentController` | ✅ خلص |
| 3 | products_list | `products_list_screen.dart` (19KB) | `features/products_list/` — 17 ملف | `ProductsListController` | ✅ خلص |
| 4 | add_edit_product | `add_product_screen.dart` (38KB) | `features/add_edit_product/` — 26 ملف | `ProductFormController` | ✅ خلص |
| 5 | inventory | `inventory_screen.dart` (14KB) | `features/inventory/` — 14 ملف | `InventoryController` | ✅ خلص |
| 6 | stock_transfer_stocktake | `stock_transfer_dialog.dart` (26KB) + `stocktake_screen.dart` (22KB) | `features/stock_transfer_stocktake/` — 33 ملف | `StockTransferController` + `StocktakeController` | ✅ خلص |
| 7 | purchase_orders | `purchase_orders_screen.dart` (13KB) + `create_purchase_order_screen.dart` (23KB) + `receive_goods_dialog.dart` (18KB) | `features/purchase_orders/` — 40 ملف | `PurchaseOrdersController` + `CreatePurchaseOrderController` + `ReceiveGoodsController` | ✅ خلص |
| 8 | customers | `customers_list_screen.dart` (13KB) + `customer_profile_screen.dart` (20KB) | `features/customers/` — 25 ملف | `CustomersListController` + `CustomerProfileController` | ✅ خلص |
| 9 | suppliers | `suppliers_list_screen.dart` (10KB) + `supplier_profile_screen.dart` (15KB) | `features/suppliers/` — 22 ملف | `SuppliersListController` + `SupplierProfileController` | ✅ خلص |
| 10 | employees_permissions | `employees_list_screen.dart` (10KB) + `roles_permissions_screen.dart` (24KB) | `features/employees_permissions/` — 22 ملف | `EmployeesListController` + `RolesPermissionsController` | ✅ خلص |
| 11 | cashier_shift | `open_shift_dialog.dart` (7KB) + `close_shift_dialog.dart` (17KB) | `features/cashier_shift/` — 15 ملف | `ShiftController` | ✅ خلص |
| 12 | returns | `returns_screen.dart` (29KB) | `features/returns/` — 20 ملف | `ReturnsController` | ✅ خلص |
| 13 | promotions | `promotions_screen.dart` (25KB) | `features/promotions/` — 21 ملف | `PromotionsController` | ✅ خلص |
| 14 | loyalty | `loyalty_screen.dart` (22KB) | `features/loyalty/` — 13 ملف | `LoyaltyController` | ✅ خلص |
| 15 | dashboard | `dashboard_screen.dart` (46KB) | `features/dashboard/` — 23 ملف | `DashboardController` | ✅ خلص |
| 16 | expenses | `expenses_screen.dart` (23KB) | `features/expenses/` — 18 ملف | `ExpensesController` + `AddExpenseController` | ✅ خلص |
| 17 | branches | `branches_screen.dart` (24KB) | `features/branches/` — 17 ملف | `BranchesController` + `AddBranchController` | ✅ خلص |
| 18 | settings | `settings_screen.dart` (37KB) | `features/settings/` — 19 ملف | `SettingsController` | ✅ خلص |

**الإجمالي:** 21 ملف قديم ضخم (≈470KB) اتحوّلوا لـ396 ملف صغير موزّعين على 18 feature.

## ملاحظات مهمة لكل feature

- **pos_sale** — السلة والخصم والعميل في `CartController`. بيستدعي feature الدفع من `cart_actions.dart`.
- **payment** — الدفعات والتقسيم في `PaymentController`؛ أنيميشن النجاح فضل في الـState لأنه محتاج `TickerProvider`.
- **products_list** — البحث/الفئة/التبويب/الفرز في controller واحد، مع كاش للصفوف بيتلغي مع أي تغيير.
- **add_edit_product** — كل حقول الفورم + التبديل بين التبويبات في `ProductFormController` واحد،
  والـ`TabController` جوه الكنترولر وبياخد `vsync` من الشاشة.
- **inventory** — فلتر الفرع والفرز في الكنترولر. أنيميشن دخول البطاقات جوه `InventoryStatCards`
  عشان الشاشة تفضل `StatelessWidget`.
- **stock_transfer_stocktake** — الاتنين تحت نفس الـfeature بس منفصلين تمامًا، كل واحد بـcontroller
  خاص بيه وwidgets مسبوقة بـ`transfer_` أو `stocktake_`.
- **purchase_orders** — تلات شاشات: الجدول، إنشاء أمر، واستلام البضاعة. الـwidgets مسبوقة بـ
  `create_po_` أو `receive_`.
- **customers / suppliers** — نفس البنية: قائمة + ملف بتلات تبويبات، كل تبويب Widget مستقل.
- **employees_permissions** — كل قسم صلاحيات بيتبني بـ`PermissionGroupCard` من
  `MockData.permissionGroups`، والدور المختار وكل Switch في `RolesPermissionsController`.
- **cashier_shift** — حوارين منفصلين وكنترولر واحد شايل الرصيد الافتتاحي والعدّ الفعلي؛
  كل حوار بيعمل نسخة خاصة بيه.
- **returns** — `ReturnsController` شايل الفاتورة المختارة والأصناف المحددة وكميات الإرجاع.
- **promotions** — الكنترولر شايل فلاتر القائمة **و**نموذج الإنشاء؛ الحوار بياخد نفس النسخة
  بـ`.value` و`resetForm()` بتتنده قبل كل فتح.
- **loyalty** — كارت المستوى اتقسم لـheader + benefits، وصف الجدول لـrank badge + tier pill + points cell.
- **dashboard** — `DashboardController` شايل الفترة والفرع وكل الحسابات المشتقة.
  إعدادات الـ`LineChart` اتحطّت في `models/sales_trend_chart_data.dart` عشان ملف الويدجت يفضل مقروء.
- **expenses** — `ExpensesController` للقايمة والفلاتر، و`AddExpenseController` للنموذج (نسخة جديدة كل فتح).
- **branches** — `BranchesController` للفروع المضافة، و`AddBranchController` للنموذج.
- **settings** — القسم المختار وكل قيم الإعدادات في `SettingsController` (شايل كمان أنيميشن الـFade).
  كل قسم إعدادات Widget مستقل، والأجهزة فيها `DeviceCard` + `DeviceStatusRow`.

## اللي اتحطّ في `lib/core/` (المشترك بين أكتر من feature)

**widgets:**
- `app_snack_bar.dart` → `showPlainSnackBar()` — التنبيه النصي البسيط (بـ`width` اختياري).
- `app_tab_bar.dart` → `AppTabBar` — شريط التبويبات الموحّد (add_edit_product + customers + suppliers).
- `icon_tab_label.dart` → `IconTabLabel` — تبويب بأيقونة وعنوان.
- `labeled_field.dart` → `LabeledField` — عنصر إدخال بعنوان فوقه (6 features).
- `not_found_state.dart` → `NotFoundState` — حالة «غير موجود» (customers + suppliers).
- `hover_row_action.dart` → `HoverRowAction` — غلاف إظهار إجراءات الصف عند الـHover.
- `hover_row_button.dart` → `HoverRowButton` — زرار الصف (purchase_orders + customers + suppliers).
- `phone_cell.dart` → `PhoneCell` — خلية رقم الهاتف (customers + suppliers).
- `staggered_reveal.dart` → `StaggeredReveal` — أنيميشن الدخول المتدرّج (dashboard + inventory).
- `progress_track.dart` → `ProgressTrack` — شريط النسبة الأفقي (dashboard).
- `dashed_border_painter.dart` → `DashedBorderPainter` — الإطار المتقطّع (add_edit_product + expenses).

**models:**
- `purchase_order_status_tone.dart` → `PurchaseOrderStatusTone` extension (purchase_orders + suppliers).

## متبقّي في `lib/screens/` (مش من ضمن الـ18)

- `reports_screen.dart` (55KB) — **شاشة شغالة ومربوطة بالراوتر على `/reports`**، وما كانتش ضمن أي
  feature في الخطة. محتاجة تتعمل لها ريفاكتور كـfeature رقم 19.
- `placeholder_screen.dart` (3KB) — شاشة الـfallback للمسارات غير المعروفة (بيستخدمها
  `errorBuilder` في `main.dart` و`navigation_test.dart`).

الاتنين دول **مش بقايا** — شغالين فعليًا، فما اتمسحوش.
