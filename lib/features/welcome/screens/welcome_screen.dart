import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../widgets/welcome_quick_links.dart';

/// شاشة الترحيب — أول شاشة بتظهر عند فتح البرنامج.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.page,
      child: Container(
        width: double.infinity,
        decoration: AppDecorations.card(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: <Color>[AppColors.accent, Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.xl + 4),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.35),
                        blurRadius: 28,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.storefront_rounded,
                    size: 44,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Text(
                  'أهلاً بك في POS System',
                  style: AppText.pageTitle.copyWith(fontSize: 26),
                ),
                const SizedBox(height: AppSpacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Text(
                    'اختر شاشة من القائمة الجانبية للبدء، أو ادخل مباشرةً '
                    'إلى نقطة البيع لتسجيل أول فاتورة.',
                    textAlign: TextAlign.center,
                    style: AppText.body.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 14.5,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                const WelcomeQuickLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
