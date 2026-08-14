import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/nav_list_tile.dart';
import '../../../theme/app_theme.dart';
import '../controllers/settings_controller.dart';
import '../models/settings_section.dart';

/// القائمة الجانبية الفرعية لأقسام الإعدادات.
class SettingsSectionsList extends StatelessWidget {
  const SettingsSectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settings = context.watch<SettingsController>();

    return Container(
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: <Widget>[
          for (final SettingsSection s in SettingsSection.values)
            NavListTile(
              icon: s.icon,
              label: s.label,
              description: s.description,
              selected: settings.section == s,
              onTap: () => settings.selectSection(s),
            ),
        ],
      ),
    );
  }
}
