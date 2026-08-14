import '../../../mock_data/mock_data.dart';

/// سطر مجمّع حسب الفئة (بيُستخدم في تقرير الأرباح).
class CategoryReportRow {
  const CategoryReportRow({
    required this.category,
    required this.items,
    required this.units,
    required this.revenue,
    required this.cost,
  });

  final ProductCategory category;
  final int items;
  final int units;
  final double revenue;
  final double cost;

  double get profit => revenue - cost;
  double get margin => revenue == 0 ? 0 : (profit / revenue) * 100;
}
