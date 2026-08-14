import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// خلية الفرع: أيقونة (نجمة للفرع الرئيسي) + الاسم.
class StockBranchCell extends StatelessWidget {
  const StockBranchCell({super.key, required this.branch});

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          branch.isMain ? Icons.star_rounded : Icons.store_outlined,
          size: 15,
          color: branch.isMain ? AppColors.warning : AppColors.textMuted,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            branch.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.body.copyWith(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
