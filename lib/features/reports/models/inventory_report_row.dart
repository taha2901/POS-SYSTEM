import '../../../mock_data/mock_data.dart';

/// سطر قيمة المخزون لفئة واحدة.
class InventoryReportRow {
  const InventoryReportRow({
    required this.categoryId,
    required this.items,
    required this.units,
    required this.cost,
    required this.retail,
  });

  final String categoryId;
  final int items;
  final int units;
  final double cost;
  final double retail;

  ProductCategory? get category => MockData.categoryById(categoryId);

  double get expectedProfit => retail - cost;
}
