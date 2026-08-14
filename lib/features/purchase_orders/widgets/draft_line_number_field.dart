import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/app_theme.dart';

/// خانة رقمية صغيرة في صف الأمر (الكمية أو سعر الشراء).
class DraftLineNumberField extends StatelessWidget {
  const DraftLineNumberField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.digitsOnly,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool digitsOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.numberWithOptions(decimal: !digitsOnly),
        inputFormatters: <TextInputFormatter>[
          if (digitsOnly)
            FilteringTextInputFormatter.digitsOnly
          else
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ],
        onChanged: onChanged,
        style: AppText.amountSm.copyWith(fontSize: 13.5),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        ),
      ),
    );
  }
}
