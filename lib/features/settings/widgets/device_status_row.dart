import 'package:flutter/material.dart';

import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';

/// سطر حالة الجهاز: نقطة ملوّنة + الحالة + المنفذ.
class DeviceStatusRow extends StatelessWidget {
  const DeviceStatusRow({super.key, required this.device});

  final ConnectedDevice device;

  @override
  Widget build(BuildContext context) {
    final Color statusColor =
        device.isConnected ? AppColors.success : AppColors.textMuted;

    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
            boxShadow: device.isConnected
                ? <BoxShadow>[
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.45),
                      blurRadius: 6,
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          device.isConnected ? 'متصل' : 'غير متصل',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: statusColor,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Text(
            '• ${device.port}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption.copyWith(fontSize: 11),
          ),
        ),
      ],
    );
  }
}
