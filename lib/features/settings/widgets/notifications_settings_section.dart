import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/settings_controller.dart';
import 'setting_switch.dart';
import 'settings_panel.dart';

/// قسم إعدادات الإشعارات.
class NotificationsSettingsSection extends StatelessWidget {
  const NotificationsSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settings = context.watch<SettingsController>();

    return SettingsPanel(
      children: <Widget>[
        SettingSwitch(
          title: 'تنبيه نقص المخزون',
          subtitle: 'إشعار لما صنف يوصل لنقطة إعادة الطلب',
          value: settings.notifyLowStock,
          onChanged: settings.setNotifyLowStock,
        ),
        SettingSwitch(
          title: 'التقرير اليومي',
          subtitle: 'ملخص المبيعات على الإيميل كل يوم 11 م',
          value: settings.notifyDailyReport,
          onChanged: settings.setNotifyDailyReport,
        ),
        SettingSwitch(
          title: 'تنبيه إغلاق الوردية',
          subtitle: 'إشعار للمدير عند وجود فرق في الدرج',
          value: settings.notifyShiftClose,
          onChanged: settings.setNotifyShiftClose,
        ),
        const SettingSwitch(
          title: 'تنبيه انتهاء الصلاحية',
          subtitle: 'قبل انتهاء صلاحية الأصناف بـ30 يوم',
          value: true,
          onChanged: _ignore,
          isLast: true,
        ),
      ],
    );
  }
}

/// مفتاح لسه مش مربوط بحالة — بيفضل ثابت زي الأصل.
void _ignore(bool _) {}
