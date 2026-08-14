import 'package:flutter/material.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import 'device_card.dart';
import 'settings_panel.dart';

/// قسم الأجهزة المتصلة.
class DevicesSettingsSection extends StatelessWidget {
  const DevicesSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPanel(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.info_outline_rounded,
              size: 16,
              color: AppColors.textMuted,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'الأجهزة المتصلة بجهاز الكاشير الحالي — اضغط «اختبار الاتصال» '
                'للتأكد إن الجهاز شغال.',
                style: AppText.caption.copyWith(fontSize: 12),
              ),
            ),
            SecondaryButton(
              label: 'بحث عن أجهزة',
              icon: Icons.refresh_rounded,
              size: AppButtonSize.small,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 340,
            mainAxisExtent: 186,
            mainAxisSpacing: AppSpacing.lg,
            crossAxisSpacing: AppSpacing.lg,
          ),
          children: <Widget>[
            for (final ConnectedDevice d in MockData.devices)
              DeviceCard(device: d),
          ],
        ),
      ],
    );
  }
}
