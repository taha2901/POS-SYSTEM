import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';

/// حالة شاشة برنامج الولاء: قيمة آلية الكسب المُدخلة.
class LoyaltyController extends ChangeNotifier {
  /// عدد النقاط لكل جنيه
  late final TextEditingController rateController = TextEditingController(
    text: MockData.pointsPerEgp.toString(),
  );

  /// المبلغ المستخدم في المثال الحي تحت الحقل
  static const double exampleInvoice = 500;

  double get rate => double.tryParse(rateController.text.trim()) ?? 0;

  int get examplePoints => (exampleInvoice * rate).round();

  double get exampleDiscount => examplePoints * MockData.pointValue;

  List<Customer> get topCustomers => MockData.topCustomersByPoints;

  int get totalGrantedPoints =>
      topCustomers.fold<int>(0, (int s, Customer c) => s + c.points);

  /// عدد العملاء الواصلين لمستوى معيّن.
  int membersCountFor(LoyaltyTierInfo tier) => topCustomers
      .where((Customer c) => MockData.tierForPoints(c.points)?.name == tier.name)
      .length;

  void rateChanged([String? _]) => notifyListeners();

  @override
  void dispose() {
    rateController.dispose();
    super.dispose();
  }
}
