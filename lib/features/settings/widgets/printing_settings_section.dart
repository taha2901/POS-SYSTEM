import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_form_field.dart';
import '../../../theme/app_theme.dart';
import '../controllers/settings_controller.dart';
import 'receipt_preview.dart';
import 'setting_switch.dart';
import 'settings_panel.dart';

/// قسم إعدادات الطباعة والإيصالات.
class PrintingSettingsSection extends StatelessWidget {
  const PrintingSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settings = context.watch<SettingsController>();

    return SettingsPanel(
      children: <Widget>[
        AppFormField(
          label: 'نص أسفل الإيصال',
          controller: settings.footerNoteController,
          maxLines: 2,
          hint: 'رسالة شكر أو سياسة الاسترجاع',
        ),
        const SizedBox(height: AppSpacing.xl),
        SettingSwitch(
          title: 'طباعة الإيصال تلقائيًا بعد الدفع',
          subtitle: 'من غير ما الكاشير يضغط زر الطباعة',
          value: settings.printAuto,
          onChanged: settings.setPrintAuto,
        ),
        SettingSwitch(
          title: 'طباعة شعار المتجر',
          subtitle: 'يظهر أعلى الإيصال',
          value: settings.printLogo,
          onChanged: settings.setPrintLogo,
          isLast: true,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text('معاينة الإيصال', style: AppText.label.copyWith(fontSize: 12.5)),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: ReceiptPreview(footer: settings.footerNoteController.text),
        ),
      ],
    );
  }
}
