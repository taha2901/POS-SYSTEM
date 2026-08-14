import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../theme/app_theme.dart';
import '../controllers/settings_controller.dart';
import '../models/settings_section.dart';
import '../widgets/settings_content.dart';
import '../widgets/settings_sections_list.dart';

/// شاشة الإعدادات — بتجمّع القائمة الفرعية ومحتوى القسم المختار بس.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  /// الكنترولر محتاج vsync عشان أنيميشن الـFade عند تبديل القسم.
  late final SettingsController _settings = SettingsController(vsync: this);

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }

  void _save() {
    showPlainSnackBar(
      context,
      'تم حفظ إعدادات «${_settings.section.label}» (تجريبي)',
      width: 460,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsController>.value(
      value: _settings,
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ScreenHeader(
              title: 'الإعدادات',
              subtitle: 'ضبط النظام حسب طبيعة نشاطك',
              actions: <Widget>[
                PrimaryButton(
                  label: 'حفظ التغييرات',
                  icon: Icons.save_outlined,
                  onPressed: _save,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            const Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // القائمة الفرعية (يمين في RTL)
                  SizedBox(width: 272, child: SettingsSectionsList()),
                  SizedBox(width: AppSpacing.xl),
                  Expanded(child: SettingsContent()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
