import 'package:flutter_test/flutter_test.dart';
import 'package:pos_system/features/pos_sale/controllers/cart_controller.dart';
import 'package:pos_system/features/pos_sale/controllers/sales_session_controller.dart';
import 'package:pos_system/features/pos_sale/models/cart_discount.dart';
import 'package:pos_system/features/pos_sale/models/held_invoice.dart';
import 'package:pos_system/mock_data/mock_data.dart';

void main() {
  group('الخصم', () {
    test('خصم بمبلغ ثابت بيتخصم زي ما هو', () {
      final CartController cart = CartController(number: 1)
        ..addProduct(MockData.products.first)
        ..setDiscount(const CartDiscount(type: DiscountType.amount, value: 40));

      expect(cart.effectiveDiscount, 40);
      expect(cart.discount.shortLabel, '');
    });

    test('خصم بنسبة بيتحسب من المجموع الفرعي', () {
      final CartController cart = CartController(number: 1)
        ..addProduct(MockData.products.first)
        ..setDiscount(const CartDiscount(type: DiscountType.percent, value: 10));

      expect(cart.effectiveDiscount, closeTo(cart.subtotal * 0.1, 0.001));
      expect(cart.discount.shortLabel, ' (10%)');
    });

    test('خصم النسبة بيتحدّث لما السلة تكبر', () {
      final CartController cart = CartController(number: 1)
        ..addProduct(MockData.products.first)
        ..setDiscount(const CartDiscount(type: DiscountType.percent, value: 10));

      final double before = cart.effectiveDiscount;
      cart.addProduct(MockData.products[1]);

      expect(cart.effectiveDiscount, greaterThan(before));
    });

    test('الخصم مبيعديش المجموع الفرعي', () {
      final CartController cart = CartController(number: 1)
        ..addProduct(MockData.products.first)
        ..setDiscount(
          const CartDiscount(type: DiscountType.amount, value: 999999),
        );

      expect(cart.effectiveDiscount, cart.subtotal);
      expect(cart.total, 0);
    });
  });

  group('الفواتير المتعددة', () {
    test('بتبدأ بفاتورة واحدة مش بتتقفل', () {
      final SalesSessionController session = SalesSessionController();

      expect(session.carts.length, 1);
      expect(session.canCloseTabs, isFalse);
    });

    test('فتح فاتورة جديدة بيخليها النشطة', () {
      final SalesSessionController session = SalesSessionController()
        ..openNew();

      expect(session.carts.length, 2);
      expect(session.activeIndex, 1);
      expect(session.canCloseTabs, isTrue);
    });

    test('كل فاتورة أصنافها مستقلة', () {
      final SalesSessionController session = SalesSessionController();
      session.active.addProduct(MockData.products.first);
      session.openNew();

      expect(session.active.isEmpty, isTrue);
      expect(session.carts.first.itemsCount, 1);
    });

    test('التبديل بين التبويبات بيرجّع نفس السلة', () {
      final SalesSessionController session = SalesSessionController();
      session.active.addProduct(MockData.products.first);
      session
        ..openNew()
        ..switchTo(0);

      expect(session.active.itemsCount, 1);
    });

    test('قفل تبويب بيظبّط الفاتورة النشطة', () {
      final SalesSessionController session = SalesSessionController()
        ..openNew()
        ..closeAt(1);

      expect(session.carts.length, 1);
      expect(session.activeIndex, 0);
    });
  });

  group('الفواتير المعلّقة', () {
    test('التعليق بيحفظ الفاتورة ويفضّي التبويب', () {
      final SalesSessionController session = SalesSessionController();
      session.active.addProduct(MockData.products.first);
      session.holdActive();

      expect(session.heldCount, 1);
      expect(session.active.isEmpty, isTrue);
      expect(session.held.first.itemsCount, 1);
    });

    test('مبيعلّقش فاتورة فاضية', () {
      final SalesSessionController session = SalesSessionController()
        ..holdActive();

      expect(session.heldCount, 0);
    });

    test('الاسترجاع بيرجّع الأصناف والخصم ويشيلها من المعلّقة', () {
      final SalesSessionController session = SalesSessionController();
      session.active
        ..addProduct(MockData.products.first)
        ..setDiscount(const CartDiscount(type: DiscountType.amount, value: 25));
      session.holdActive();

      final HeldInvoice invoice = session.held.first;
      session.restore(invoice);

      expect(session.heldCount, 0);
      expect(session.active.itemsCount, 1);
      expect(session.active.discount.value, 25);
    });

    test('الاسترجاع بيفتح تبويب جديد لو الحالي فيه أصناف', () {
      final SalesSessionController session = SalesSessionController();
      session.active.addProduct(MockData.products.first);
      session.holdActive();

      // التبويب رجع فاضي، فبنحطّ فيه صنف تاني قبل الاسترجاع
      session.active.addProduct(MockData.products[1]);
      session.restore(session.held.first);

      expect(session.carts.length, 2);
      expect(session.activeIndex, 1);
    });

    test('حذف فاتورة معلّقة بيشيلها', () {
      final SalesSessionController session = SalesSessionController();
      session.active.addProduct(MockData.products.first);
      session
        ..holdActive()
        ..deleteHeld(session.held.first);

      expect(session.heldCount, 0);
    });
  });

  group('إتمام الدفع', () {
    test('بيفضّي الفاتورة لو هي الوحيدة', () {
      final SalesSessionController session = SalesSessionController();
      session.active.addProduct(MockData.products.first);
      session.completeActive();

      expect(session.carts.length, 1);
      expect(session.active.isEmpty, isTrue);
    });

    test('بيقفل تبويبها لو فيه غيرها', () {
      final SalesSessionController session = SalesSessionController()
        ..openNew();
      session.active.addProduct(MockData.products.first);
      session.completeActive();

      expect(session.carts.length, 1);
    });
  });
}
