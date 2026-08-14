import '../../../mock_data/mock_data.dart';

/// صف جرد: الكمية بالنظام + الكمية الفعلية المُدخلة.
class StocktakeLine {
  StocktakeLine({required this.product, required this.systemQuantity});

  final Product product;
  final int systemQuantity;

  /// null = لسه ماتجردش
  int? actualQuantity;

  bool get isCounted => actualQuantity != null;
  int get difference => (actualQuantity ?? systemQuantity) - systemQuantity;
  double get valueDifference => difference * product.cost;
}
