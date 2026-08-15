import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// الغلاف الموحّد لأي تقرير: بطاقات ملخّص + محتوى بارتفاع ثابت.
///
/// بنستخدم ارتفاع صريح مع Scroll View بدل Expanded عشان المحتوى
/// ما ينضغطش لما البطاقات تتغيّر أو الشاشة تصغّر.
class ReportBody extends StatelessWidget {
  const ReportBody({
    super.key,
    required this.summary,
    required this.content,
    this.contentHeight = 520,
  });

  final List<Widget> summary;
  final Widget content;
  final double contentHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (int i = 0; i < summary.length; i++) ...<Widget>[
                  Expanded(child: summary[i]),
                  if (i != summary.length - 1)
                    const SizedBox(width: AppSpacing.lg),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(height: contentHeight, child: content),
        ],
      ),
    );
  }
}
