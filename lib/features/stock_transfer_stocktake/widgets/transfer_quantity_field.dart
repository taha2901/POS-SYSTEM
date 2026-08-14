import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/app_theme.dart';

/// حقل كمية صغير بأزرار +/-.
class TransferQuantityField extends StatefulWidget {
  const TransferQuantityField({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.hasError = false,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final bool enabled;
  final bool hasError;

  @override
  State<TransferQuantityField> createState() => _TransferQuantityFieldState();
}

class _TransferQuantityFieldState extends State<TransferQuantityField> {
  late final TextEditingController _controller =
      TextEditingController(text: '${widget.value}');

  @override
  void didUpdateWidget(TransferQuantityField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value &&
        _controller.text != '${widget.value}') {
      _controller.text = '${widget.value}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _stepButton(IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.enabled ? onTap : null,
        child: Container(
          width: 32,
          height: 40,
          decoration: BoxDecoration(
            color: widget.enabled ? AppColors.surfaceAlt : AppColors.surface,
            border: Border.all(color: AppColors.border),
          ),
          child: Icon(
            icon,
            size: 15,
            color: widget.enabled
                ? AppColors.textSecondary
                : AppColors.textMuted,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        widget.hasError ? AppColors.danger : AppColors.border;

    return SizedBox(
      height: 40,
      child: Row(
        children: <Widget>[
          _stepButton(Icons.remove_rounded, () {
            if (widget.value > 1) widget.onChanged(widget.value - 1);
          }),
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: widget.enabled,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (String v) => widget.onChanged(int.tryParse(v) ?? 0),
              style: AppText.amountSm.copyWith(
                fontSize: 13.5,
                color: widget.hasError ? AppColors.danger : null,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: widget.hasError
                    ? AppColors.dangerSoft
                    : AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
            ),
          ),
          _stepButton(
            Icons.add_rounded,
            () => widget.onChanged(widget.value + 1),
          ),
        ],
      ),
    );
  }
}
