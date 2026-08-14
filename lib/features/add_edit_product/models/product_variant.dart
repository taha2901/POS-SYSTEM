/// صف في جدول المتغيرات (مقاس/لون/SKU/كمية).
class ProductVariant {
  ProductVariant({
    this.size = '',
    this.color = '',
    this.sku = '',
    this.quantity = '',
  });

  String size;
  String color;
  String sku;
  String quantity;
}
