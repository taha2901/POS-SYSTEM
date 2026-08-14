import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/screen_header.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/suppliers_list_controller.dart';
import 'suppliers_filter_dropdown.dart';

/// شريط فوق الجدول: العنوان والعدّاد والبحث وفلتر الحالة.
class SuppliersFilterBar extends StatelessWidget {
  const SuppliersFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final SuppliersListController suppliers =
        context.watch<SuppliersListController>();

    return Row(
      children: <Widget>[
        Text('قائمة الموردين', style: AppText.sectionTitle),
        const SizedBox(width: AppSpacing.md),
        Text('(${Fmt.count(suppliers.visibleCount)})', style: AppText.caption),
        const Spacer(),
        SearchField(
          controller: suppliers.searchController,
          hint: 'ابحث بالاسم أو مسؤول التواصل…',
          onChanged: suppliers.setQuery,
        ),
        const SizedBox(width: AppSpacing.md),
        const SuppliersFilterDropdown(),
      ],
    );
  }
}
