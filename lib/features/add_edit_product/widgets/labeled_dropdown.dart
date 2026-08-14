import 'package:flutter/material.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/labeled_field.dart';

/// قائمة منسدلة بعنوان فوقها — بنفس شكل [AppFormField] في النموذج.
class LabeledDropdown<T> extends StatelessWidget {
  const LabeledDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.icon,
  });

  final String label;
  final T value;
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T> onChanged;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: label,
      child: AppDropdown<T>(
        value: value,
        width: double.infinity,
        height: 48,
        icon: icon,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
