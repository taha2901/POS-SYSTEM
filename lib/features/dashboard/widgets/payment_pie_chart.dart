import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../models/payment_slice.dart';
import 'payment_pie_center.dart';
import 'payment_pie_legend.dart';

/// بطاقة توزيع طرق الدفع.
class PaymentPieChart extends StatefulWidget {
  const PaymentPieChart({super.key, required this.slices});

  final List<PaymentSlice> slices;

  @override
  State<PaymentPieChart> createState() => _PaymentPieChartState();
}

class _PaymentPieChartState extends State<PaymentPieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final List<PaymentSlice> slices = widget.slices;
    final double total = slices.fold<double>(
      0,
      (double a, PaymentSlice s) => a + s.value,
    );
    final bool touched = _touchedIndex >= 0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: AppDecorations.card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: AppRadius.smAll,
                ),
                child: const Icon(
                  Icons.pie_chart_rounded,
                  size: 19,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'طرق الدفع',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.sectionTitle,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 52,
                    startDegreeOffset: -90,
                    pieTouchData: PieTouchData(
                      touchCallback: (
                        FlTouchEvent event,
                        PieTouchResponse? response,
                      ) {
                        setState(() {
                          _touchedIndex =
                              response?.touchedSection?.touchedSectionIndex ??
                                  -1;
                        });
                      },
                    ),
                    sections: <PieChartSectionData>[
                      for (int i = 0; i < slices.length; i++)
                        PieChartSectionData(
                          value: slices[i].value,
                          color: slices[i].color,
                          radius: _touchedIndex == i ? 34 : 28,
                          showTitle: false,
                        ),
                    ],
                  ),
                ),
                PaymentPieCenter(
                  value: touched
                      ? Fmt.percent(
                          total == 0
                              ? 0
                              : slices[_touchedIndex].value / total * 100,
                        )
                      : Fmt.compact(total),
                  label: touched
                      ? slices[_touchedIndex].label
                      : 'إجمالي المبيعات',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          PaymentPieLegend(slices: slices, total: total),
        ],
      ),
    );
  }
}
