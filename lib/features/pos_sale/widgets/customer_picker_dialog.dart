import 'package:flutter/material.dart';

import '../../../core/widgets/secondary_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import 'customer_picker_tile.dart';

/// يفتح حوار اختيار العميل ويرجّع العميل المختار (أو null).
Future<Customer?> showCustomerPicker(BuildContext context) {
  return showDialog<Customer>(
    context: context,
    builder: (BuildContext context) => const CustomerPickerDialog(),
  );
}

class CustomerPickerDialog extends StatefulWidget {
  const CustomerPickerDialog({super.key});

  @override
  State<CustomerPickerDialog> createState() => _CustomerPickerDialogState();
}

class _CustomerPickerDialogState extends State<CustomerPickerDialog> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final String q = _query.trim().toLowerCase();
    final List<Customer> results = MockData.customers
        .where((Customer c) =>
            q.isEmpty ||
            c.name.toLowerCase().contains(q) ||
            c.phone.contains(q))
        .toList(growable: false);

    return Dialog(
      child: SizedBox(
        width: 520,
        height: 560,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Row(
                children: <Widget>[
                  Text('اختيار العميل', style: AppText.sectionTitle),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, size: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
              child: TextField(
                autofocus: true,
                onChanged: (String v) => setState(() => _query = v),
                decoration: const InputDecoration(
                  hintText: 'ابحث بالاسم أو رقم الهاتف…',
                  prefixIcon: Icon(Icons.search_rounded, size: 20),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                itemCount: results.length,
                separatorBuilder: (_, _) => const SizedBox(height: 2),
                itemBuilder: (BuildContext context, int i) =>
                    CustomerPickerTile(
                  customer: results[i],
                  onTap: () => Navigator.of(context).pop(results[i]),
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: <Widget>[
                  SecondaryButton(
                    label: 'عميل جديد',
                    icon: Icons.person_add_alt_1_rounded,
                    tone: SecondaryButtonTone.accent,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  SecondaryButton(
                    label: 'إلغاء',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
