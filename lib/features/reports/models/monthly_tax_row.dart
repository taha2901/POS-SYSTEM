import '../../../mock_data/mock_data.dart';

/// سطر شهري في الإقرار الضريبي.
class MonthlyTaxRow {
  const MonthlyTaxRow({
    required this.key,
    required this.sales,
    required this.tax,
    required this.invoices,
  });

  /// المفتاح بصيغة `السنة-الشهر`
  final String key;
  final double sales;
  final double tax;
  final int invoices;

  bool get isCurrentMonth =>
      key == '${MockData.today.year}-${MockData.today.month}';

  String get label {
    const List<String> names = <String>[
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    final List<String> parts = key.split('-');
    final int month = int.tryParse(parts[1]) ?? 1;
    return '${names[(month - 1).clamp(0, 11)]} ${parts[0]}';
  }
}
