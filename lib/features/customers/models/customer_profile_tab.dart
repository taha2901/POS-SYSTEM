import 'package:flutter/material.dart';

/// تبويبات ملف العميل بالترتيب اللي بتظهر بيه.
enum CustomerProfileTab { invoices, ledger, loyalty }

extension CustomerProfileTabInfo on CustomerProfileTab {
  String get label => switch (this) {
        CustomerProfileTab.invoices => 'سجل المشتريات',
        CustomerProfileTab.ledger => 'كشف الحساب',
        CustomerProfileTab.loyalty => 'نقاط الولاء',
      };

  IconData get icon => switch (this) {
        CustomerProfileTab.invoices => Icons.receipt_long_outlined,
        CustomerProfileTab.ledger => Icons.account_balance_outlined,
        CustomerProfileTab.loyalty => Icons.stars_outlined,
      };
}
