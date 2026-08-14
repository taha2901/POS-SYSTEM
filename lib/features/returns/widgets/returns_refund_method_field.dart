import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../mock_data/mock_data.dart';
import '../controllers/returns_controller.dart';

/// اختيار طريقة الاسترداد.
class ReturnsRefundMethodField extends StatelessWidget {
  const ReturnsRefundMethodField({super.key});

  @override
  Widget build(BuildContext context) {
    final ReturnsController returns = context.watch<ReturnsController>();

    return LabeledField(
      label: 'طريقة الاسترداد',
      child: AppDropdown<String>(
        value: returns.refundMethod,
        width: double.infinity,
        height: 48,
        icon: Icons.account_balance_wallet_outlined,
        onChanged: returns.setRefundMethod,
        items: <AppDropdownItem<String>>[
          for (final String m in MockData.refundMethods)
            AppDropdownItem<String>(value: m, label: m),
        ],
      ),
    );
  }
}
