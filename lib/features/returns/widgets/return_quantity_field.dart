import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/app_theme.dart';

/// خانة الكمية المرتجعة — بتتعطّل لو الصنف مش متحدد.
class ReturnQuantityField extends StatefulWidget {
  const ReturnQuantityField({
    super.key,
    required this.initialQuantity,
    required this.enabled,
    required this.onChanged,
  });

  final int initialQuantity;
  final bool enabled;
  final ValueChanged<int> onChanged;

  @override
  State<ReturnQuantityField> createState() => _ReturnQuantityFieldState();
}

class _ReturnQuantityFieldState extends State<ReturnQuantityField> {
  late final TextEditingController _controller =
      TextEditingController(text: '${widget.initialQuantity}');

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
        enabled: widget.enabled,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (String v) => widget.onChanged(int.tryParse(v) ?? 0),
        style: AppText.amountSm.copyWith(fontSize: 13.5),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),
          fillColor:
              widget.enabled ? AppColors.surface : AppColors.surfaceAlt,
        ),
      ),
    );
  }
}
