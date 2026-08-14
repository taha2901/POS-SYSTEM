import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// يفتح حوار الخصم ويرجّع قيمة الخصم الجديدة (أو null لو اتلغى).
Future<double?> showDiscountDialog(
  BuildContext context, {
  required double subtotal,
  required double current,
}) {
  return showDialog<double>(
    context: context,
    builder: (BuildContext context) => DiscountDialog(
      subtotal: subtotal,
      current: current,
    ),
  );
}

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({
    super.key,
    required this.subtotal,
    required this.current,
  });

  final double subtotal;
  final double current;

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.current > 0 ? widget.current.toStringAsFixed(2) : '',
  );

  double get _value => double.tryParse(_controller.text.trim()) ?? 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applyPercent(int percent) {
    setState(() {
      _controller.text =
          (widget.subtotal * percent / 100).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 440,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('خصم على الفاتورة', style: AppText.sectionTitle),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'المجموع الفرعي: ${Fmt.money(widget.subtotal)}',
                style: AppText.caption,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _controller,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                onChanged: (_) => setState(() {}),
                style: AppText.amountLg,
                decoration: InputDecoration(
                  labelText: 'قيمة الخصم',
                  suffixText: Fmt.currencySymbol,
                  prefixIcon: const Icon(
                    Icons.local_offer_outlined,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: <Widget>[
                  for (final int p in <int>[5, 10, 15, 20]) ...<Widget>[
                    Expanded(
                      child: SecondaryButton(
                        label: '$p%',
                        size: AppButtonSize.small,
                        expanded: true,
                        onPressed: () => _applyPercent(p),
                      ),
                    ),
                    if (p != 20) const SizedBox(width: AppSpacing.sm),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SecondaryButton(
                      label: 'إلغاء الخصم',
                      expanded: true,
                      tone: SecondaryButtonTone.danger,
                      onPressed: () => Navigator.of(context).pop(0.0),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: PrimaryButton(
                      label: 'تطبيق',
                      expanded: true,
                      onPressed: _value <= widget.subtotal
                          ? () => Navigator.of(context).pop(_value)
                          : null,
                    ),
                  ),
                ],
              ),
              if (_value > widget.subtotal) ...<Widget>[
                const SizedBox(height: AppSpacing.md),
                Text(
                  'قيمة الخصم أكبر من إجمالي الفاتورة',
                  style: AppText.caption.copyWith(color: AppColors.danger),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
