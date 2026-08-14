import 'package:flutter/material.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// سطر حساب مستخدم في قسم المستخدمين.
class UserAccountRow extends StatelessWidget {
  const UserAccountRow({
    super.key,
    required this.employee,
    required this.isLast,
  });

  final Employee employee;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Text(
              employee.initials,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  employee.name,
                  style: AppText.bodyMedium.copyWith(fontSize: 13.5),
                ),
                const SizedBox(height: 2),
                Text(
                  '${employee.role} • '
                  'آخر دخول ${Fmt.date(employee.lastLogin)}',
                  style: AppText.caption.copyWith(fontSize: 11.5),
                ),
              ],
            ),
          ),
          StatusBadge(
            label: employee.isActive ? 'نشط' : 'موقوف',
            tone: employee.isActive
                ? StatusTone.success
                : StatusTone.neutral,
            compact: true,
          ),
          const SizedBox(width: AppSpacing.md),
          SecondaryButton(
            label: 'إعادة تعيين كلمة المرور',
            size: AppButtonSize.small,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
