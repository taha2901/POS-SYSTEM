import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../models/cart_discount.dart';
import 'discount_presets_row.dart';
import 'discount_type_toggle.dart';

/// يفتح حوار الخصم ويرجّع الخصم الجديد (أو null لو اتلغى).
Future<CartDiscount?> showDiscountDialog(
  BuildContext context, {
  required double subtotal,
  required CartDiscount current,
}) {
  return showDialog<CartDiscount>(
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
  final CartDiscount current;

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  late DiscountType _type = widget.current.type;
  late final TextEditingController _controller = TextEditingController(
    text: widget.current.isEmpty
        ? ''
        : Fmt.trimDecimals(widget.current.value),
  );

  double get _value => double.tryParse(_controller.text.trim()) ?? 0;

  CartDiscount get _discount => CartDiscount(type: _type, value: _value);

  /// قيمة الخصم بالجنيه — للمعاينة تحت الخانة.
  double get _amount => _discount.amountFor(widget.subtotal);

  bool get _isTooBig => _type == DiscountType.percent
      ? _value > 100
      : _value > widget.subtotal;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchType(DiscountType type) {
    if (type == _type) return;
    // القيمة معناها بيتغيّر تمامًا، فبنفضّيها بدل ما نطبّق رقم غلط
    setState(() {
      _type = type;
      _controller.clear();
    });
  }

  void _applyPreset(double value) {
    setState(() => _controller.text = Fmt.trimDecimals(value));
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
              DiscountTypeToggle(selected: _type, onChanged: _switchType),
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
                  labelText: _type == DiscountType.amount
                      ? 'قيمة الخصم'
                      : 'نسبة الخصم',
                  suffixText: _type.suffix,
                  prefixIcon: const Icon(
                    Icons.local_offer_outlined,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              DiscountPresetsRow(type: _type, onSelected: _applyPreset),
              // معاينة قيمة النسبة بالجنيه
              if (_type == DiscountType.percent && _value > 0 && !_isTooBig)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: Text(
                    'يعادل خصم ${Fmt.money(_amount)}',
                    style: AppText.caption.copyWith(color: AppColors.success),
                  ),
                ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SecondaryButton(
                      label: 'إلغاء الخصم',
                      expanded: true,
                      tone: SecondaryButtonTone.danger,
                      onPressed: () => Navigator.of(context).pop(
                        const CartDiscount.none(),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: PrimaryButton(
                      label: 'تطبيق',
                      expanded: true,
                      onPressed: _isTooBig
                          ? null
                          : () => Navigator.of(context).pop(_discount),
                    ),
                  ),
                ],
              ),
              if (_isTooBig) ...<Widget>[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _type == DiscountType.percent
                      ? 'النسبة لازم تكون 100% أو أقل'
                      : 'قيمة الخصم أكبر من إجمالي الفاتورة',
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
