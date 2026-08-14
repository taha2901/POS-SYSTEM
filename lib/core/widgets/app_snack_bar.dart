import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// رسالة سريعة بنص بس — من غير أيقونة.
///
/// شاشات الجداول (المنتجات، المخزون…) بتستخدمها للتنبيهات التجريبية.
void showPlainSnackBar(
  BuildContext context,
  String message, {
  double width = 420,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message), width: width));
}

/// رسالة سريعة موحّدة الشكل في كل الشاشات.
void showAppSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
  double width = 420,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Icon(
              isError
                  ? Icons.error_outline_rounded
                  : Icons.check_circle_outline_rounded,
              size: 18,
              color: isError ? const Color(0xFFFCA5A5) : const Color(0xFF6EE7B7),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(message)),
          ],
        ),
        duration: const Duration(seconds: 2),
        width: width,
      ),
    );
}
