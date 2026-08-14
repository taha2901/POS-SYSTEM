import 'package:flutter/material.dart';

/// تبويبات ملف المورد بالترتيب اللي بتظهر بيه.
enum SupplierProfileTab { products, ledger, orders }

extension SupplierProfileTabInfo on SupplierProfileTab {
  String get label => switch (this) {
        SupplierProfileTab.products => 'المنتجات الموردة',
        SupplierProfileTab.ledger => 'كشف الحساب والمدفوعات',
        SupplierProfileTab.orders => 'أوامر الشراء',
      };

  IconData get icon => switch (this) {
        SupplierProfileTab.products => Icons.inventory_2_outlined,
        SupplierProfileTab.ledger => Icons.account_balance_outlined,
        SupplierProfileTab.orders => Icons.receipt_long_outlined,
      };
}
