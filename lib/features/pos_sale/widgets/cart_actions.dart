import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../features/payment/models/payment_result.dart';
import '../../../features/payment/screens/payment_dialog.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/cart_controller.dart';
import 'discount_dialog.dart';

/// أزرار أسفل السلة: تعليق الفاتورة، خصم، والدفع.
class CartActions extends StatelessWidget {
  const CartActions({super.key});

  void _holdInvoice(BuildContext context) {
    showAppSnackBar(context, 'تم تعليق الفاتورة مؤقتًا');
    context.read<CartController>().clear();
  }

  Future<void> _applyDiscount(BuildContext context) async {
    final CartController cart = context.read<CartController>();
    final double? value = await showDiscountDialog(
      context,
      subtotal: cart.subtotal,
      current: cart.discount,
    );
    if (value == null || !context.mounted) return;

    cart.setDiscount(value);
    showAppSnackBar(
      context,
      value > 0 ? 'تم تطبيق خصم ${Fmt.money(value)}' : 'تم إلغاء الخصم',
    );
  }

  Future<void> _pay(BuildContext context) async {
    final CartController cart = context.read<CartController>();
    final PaymentResult? result = await showPaymentDialog(
      context: context,
      total: cart.total,
      itemsCount: cart.itemsCount,
      customerName: cart.customer.name,
    );
    if (result == null || !context.mounted) return;

    cart.clear();
    showAppSnackBar(
      context,
      result.change > 0.005
          ? 'تم البيع بنجاح (${result.methodsLabel}) — الباقي ${Fmt.money(result.change)}'
          : 'تم البيع بنجاح (${result.methodsLabel}) وطباعة الفاتورة',
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartController cart = context.watch<CartController>();
    final bool hasItems = cart.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: SecondaryButton(
                label: 'تعليق الفاتورة',
                icon: Icons.pause_circle_outline_rounded,
                expanded: true,
                onPressed: hasItems ? () => _holdInvoice(context) : null,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: SecondaryButton(
                label: 'خصم',
                icon: Icons.local_offer_outlined,
                expanded: true,
                onPressed: hasItems ? () => _applyDiscount(context) : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        PrimaryButton(
          label: 'الدفع',
          icon: Icons.payments_rounded,
          size: AppButtonSize.hero,
          expanded: true,
          onPressed: hasItems ? () => _pay(context) : null,
          trailing: hasItems
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    Fmt.money(cart.total),
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
