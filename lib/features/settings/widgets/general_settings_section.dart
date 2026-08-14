import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/app_form_field.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/settings_controller.dart';
import 'setting_switch.dart';
import 'settings_panel.dart';

/// قسم الإعدادات العامة.
class GeneralSettingsSection extends StatelessWidget {
  const GeneralSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settings = context.watch<SettingsController>();

    return SettingsPanel(
      children: <Widget>[
        AppFormField(
          label: 'اسم المتجر',
          controller: settings.storeNameController,
          hint: 'الاسم اللي هيظهر على الفواتير',
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: LabeledField(
                label: 'العملة',
                child: AppDropdown<String>(
                  value: settings.currency,
                  width: double.infinity,
                  height: 48,
                  icon: Icons.payments_outlined,
                  onChanged: settings.setCurrency,
                  items: const <AppDropdownItem<String>>[
                    AppDropdownItem<String>(
                      value: 'الجنيه المصري (ج.م)',
                      label: 'الجنيه المصري (ج.م)',
                    ),
                    AppDropdownItem<String>(
                      value: 'الريال السعودي (ر.س)',
                      label: 'الريال السعودي (ر.س)',
                    ),
                    AppDropdownItem<String>(
                      value: 'الدرهم الإماراتي (د.إ)',
                      label: 'الدرهم الإماراتي (د.إ)',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: LabeledField(
                label: 'الفرع الافتراضي',
                child: AppDropdown<String>(
                  value: MockData.branches.first.id,
                  width: double.infinity,
                  height: 48,
                  icon: Icons.store_outlined,
                  onChanged: (_) {},
                  items: <AppDropdownItem<String>>[
                    for (final Branch b in MockData.branches)
                      AppDropdownItem<String>(value: b.id, label: b.name),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        const SettingSwitch(
          title: 'الوضع الليلي',
          subtitle: 'تفعيل الثيم الداكن للواجهة (قريبًا)',
          value: false,
          onChanged: _ignore,
        ),
        const SettingSwitch(
          title: 'إغلاق الوردية تلقائيًا',
          subtitle: 'إنهاء الوردية عند إغلاق البرنامج',
          value: true,
          onChanged: _ignore,
          isLast: true,
        ),
      ],
    );
  }
}

/// مفاتيح لسه مش مربوطة بحالة — بتفضل ثابتة زي الأصل.
void _ignore(bool _) {}
