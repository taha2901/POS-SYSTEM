import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/app_theme.dart';

/// خانة إدخال الكمية الفعلية — فاضية يعني الصنف لسه ماتجردش.
class StocktakeActualField extends StatefulWidget {
  const StocktakeActualField({
    super.key,
    required this.value,
    required this.fillColor,
    required this.onChanged,
  });

  final int? value;
  final Color fillColor;
  final ValueChanged<int?> onChanged;

  @override
  State<StocktakeActualField> createState() => _StocktakeActualFieldState();
}

class _StocktakeActualFieldState extends State<StocktakeActualField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value?.toString() ?? '',
  );

  @override
  void didUpdateWidget(StocktakeActualField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // بيتزامن مع «مطابقة النظام» و«تفريغ الإدخالات»
    final String expected = widget.value?.toString() ?? '';
    if (_controller.text != expected) _controller.text = expected;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (String v) =>
            widget.onChanged(v.trim().isEmpty ? null : int.tryParse(v)),
        style: AppText.amountSm.copyWith(fontSize: 14),
        decoration: InputDecoration(
          hintText: '—',
          hintStyle: AppText.caption.copyWith(fontSize: 13),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),
          fillColor: widget.fillColor,
        ),
      ),
    );
  }
}
