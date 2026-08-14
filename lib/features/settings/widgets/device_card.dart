import 'package:flutter/material.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import 'device_status_row.dart';

/// بطاقة جهاز متصل بجهاز الكاشير.
class DeviceCard extends StatefulWidget {
  const DeviceCard({super.key, required this.device});

  final ConnectedDevice device;

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  bool _hovered = false;
  bool _testing = false;

  Future<void> _test() async {
    setState(() => _testing = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _testing = false);

    showPlainSnackBar(
      context,
      widget.device.isConnected
          ? 'تم الاتصال بـ${widget.device.type.label} بنجاح'
          : 'تعذّر الاتصال بـ${widget.device.type.label} — تأكد من التوصيل',
      width: 480,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ConnectedDevice d = widget.device;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.border,
          ),
          boxShadow: _hovered ? AppShadows.lifted : AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: d.isConnected
                        ? AppColors.accent.withValues(alpha: 0.10)
                        : AppColors.surfaceAlt,
                    borderRadius: AppRadius.mdAll,
                  ),
                  child: Icon(
                    d.type.icon,
                    size: 23,
                    color: d.isConnected
                        ? AppColors.accent
                        : AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        d.type.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.cardTitle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        d.model,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.caption.copyWith(fontSize: 11.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            DeviceStatusRow(device: d),
            const Spacer(),
            SecondaryButton(
              label: _testing ? 'جارٍ الاختبار…' : 'اختبار الاتصال',
              icon: _testing
                  ? Icons.hourglass_top_rounded
                  : Icons.wifi_tethering_rounded,
              size: AppButtonSize.small,
              expanded: true,
              tone: d.isConnected
                  ? SecondaryButtonTone.accent
                  : SecondaryButtonTone.neutral,
              onPressed: _testing ? null : _test,
            ),
          ],
        ),
      ),
    );
  }
}
