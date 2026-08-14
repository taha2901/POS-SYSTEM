import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../controllers/cart_controller.dart';
import 'cart_customer_row.dart';
import 'cart_empty_state.dart';
import 'cart_header.dart';
import 'cart_items_list.dart';
import 'invoice_summary.dart';

/// بطاقة السلة على يسار شاشة الكاشير بارتفاع الشاشة الكامل.
class CartPanel extends StatelessWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = context.watch<CartController>().isEmpty;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 340, maxWidth: 460),
      child: Container(
        decoration: AppDecorations.card(),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const CartHeader(),
            const CartCustomerRow(),
            const Divider(height: 1),
            Expanded(
              child: isEmpty ? const CartEmptyState() : const CartItemsList(),
            ),
            const InvoiceSummary(),
          ],
        ),
      ),
    );
  }
}
