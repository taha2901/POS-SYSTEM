import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// الغلاف الموحّد لمحتوى أي تبويب في النموذج.
class ProductFormTabCard extends StatelessWidget {
  const ProductFormTabCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: AppDecorations.card(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
