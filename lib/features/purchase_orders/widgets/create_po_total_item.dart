import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// عنصر إجمالي صغير في الشريط السفلي (المجموع الفرعي / الضريبة).
class CreatePoTotalItem extends StatelessWidget {
  const CreatePoTotalItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label, style: AppText.label.copyWith(fontSize: 11.5)),
        const SizedBox(height: 2),
        Text(value, style: AppText.amountMd.copyWith(fontSize: 16)),
      ],
    );
  }
}
