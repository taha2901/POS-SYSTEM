import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// خلية رقم هاتف بأيقونة — بنفس الشكل في جداول العملاء والموردين.
class PhoneCell extends StatelessWidget {
  const PhoneCell({super.key, required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(
          Icons.phone_outlined,
          size: 14,
          color: AppColors.textMuted,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            phone,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.body.copyWith(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
