import '../../../mock_data/mock_data.dart';

/// أداء فرع خلال الفترة المختارة.
class BranchPerformance {
  const BranchPerformance({
    required this.branch,
    required this.sales,
    required this.change,
  });

  final Branch branch;
  final double sales;
  final double change;
}
