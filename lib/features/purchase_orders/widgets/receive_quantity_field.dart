import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/app_theme.dart';

/// خانة الكمية المستلمة دلوقتي.
class ReceiveQuantityField extends StatefulWidget {
  const ReceiveQuantityField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final int value;
  final ValueChanged<int> onChanged;

  @override
  State<ReceiveQuantityField> createState() => _ReceiveQuantityFieldState();
}

class _ReceiveQuantityFieldState extends State<ReceiveQuantityField> {
  late final TextEditingController _controller =
      TextEditingController(text: '${widget.value}');

  @override
  void didUpdateWidget(ReceiveQuantityField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // بيتزامن مع «استلام الكل» و«تصفير»
    final String expected = '${widget.value}';
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
        onChanged: (String v) => widget.onChanged(int.tryParse(v) ?? 0),
        style: AppText.amountSm.copyWith(fontSize: 14),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),
          fillColor: widget.value > 0
              ? AppColors.accentSoft
              : AppColors.surface,
        ),
      ),
    );
  }
}
