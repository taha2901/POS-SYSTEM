import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ---------------------------------------------------------------------------
/// Design language — Single Source of Truth
///
/// كل الألوان والمسافات والظلال والخطوط في التطبيق بتيجي من هنا.
/// ممنوع تعريف لون أو ظل جوه أي شاشة.
/// ---------------------------------------------------------------------------

class AppColors {
  const AppColors._();

  // ── Brand ────────────────────────────────────────────────────────────────
  /// كحلي غامق هادئ — لون الهوية الأساسي (Sidebar، العناوين، الأرقام المهمة)
  static const Color primary = Color(0xFF0F172A);
  static const Color primaryLight = Color(0xFF1E293B);
  static const Color primaryLighter = Color(0xFF334155);

  /// Accent وحيد — الأزرار المهمة والعناصر التفاعلية فقط
  static const Color accent = Color(0xFF6366F1);
  static const Color accentDark = Color(0xFF4F46E5);
  static const Color accentSoft = Color(0xFFEEF2FF);

  // ── Surfaces ─────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF1F5F9);
  static const Color surfaceHover = Color(0xFFF8FAFC);
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderStrong = Color(0xFFCBD5E1);

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textOnDark = Color(0xFFF8FAFC);
  static const Color textOnDarkMuted = Color(0xFF94A3B8);

  // ── States ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF059669);
  static const Color successSoft = Color(0xFFECFDF5);
  static const Color warning = Color(0xFFD97706);
  static const Color warningSoft = Color(0xFFFFFBEB);
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerSoft = Color(0xFFFEF2F2);
  static const Color info = Color(0xFF0284C7);
  static const Color infoSoft = Color(0xFFF0F9FF);
  static const Color neutralSoft = Color(0xFFF1F5F9);

  /// ألوان الـPlaceholders لصور المنتجات (هادية ومتناسقة مع الـPalette)
  static const List<Color> productPalette = <Color>[
    Color(0xFF6366F1),
    Color(0xFF0EA5E9),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFF14B8A6),
    Color(0xFFF97316),
  ];
}

class AppRadius {
  const AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double pill = 999;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlAll = BorderRadius.all(Radius.circular(xl));
}

class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// الحشو الافتراضي لأي شاشة داخل الـShell
  static const EdgeInsets page = EdgeInsets.all(xxl);
}

class AppShadows {
  const AppShadows._();

  /// ظل ناعم جدًا للـCards العادية
  static const List<BoxShadow> soft = <BoxShadow>[
    BoxShadow(
      color: Color(0x0A0F172A),
      blurRadius: 12,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x05000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  /// ظل متوسط — عند الـHover أو العناصر المرفوعة
  static const List<BoxShadow> lifted = <BoxShadow>[
    BoxShadow(
      color: Color(0x140F172A),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  /// ظل الحوارات والقوائم المنسدلة
  static const List<BoxShadow> overlay = <BoxShadow>[
    BoxShadow(
      color: Color(0x1F0F172A),
      blurRadius: 40,
      offset: Offset(0, 16),
    ),
  ];

  /// توهج خفيف بلون الـAccent تحت الأزرار الأساسية
  static const List<BoxShadow> accentGlow = <BoxShadow>[
    BoxShadow(
      color: Color(0x336366F1),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];
}

/// حاويات جاهزة عشان كل الـCards في التطبيق تبقى بنفس الشكل بالظبط.
class AppDecorations {
  const AppDecorations._();

  static BoxDecoration card({
    double radius = AppRadius.lg,
    Color color = AppColors.surface,
    bool elevated = true,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor ?? AppColors.border),
      boxShadow: elevated ? AppShadows.soft : null,
    );
  }

  static BoxDecoration hoveredCard({double radius = AppRadius.lg}) {
    return BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
      boxShadow: AppShadows.lifted,
    );
  }
}

/// أنماط النصوص المتخصّصة — خصوصًا الأرقام والمبالغ (أهم عنصر في شاشات الـPOS).
class AppText {
  const AppText._();

  static TextStyle _cairo({
    required double size,
    required FontWeight weight,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.cairo(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // العناوين
  static TextStyle get pageTitle =>
      _cairo(size: 22, weight: FontWeight.w700, height: 1.3);
  static TextStyle get sectionTitle =>
      _cairo(size: 17, weight: FontWeight.w700, height: 1.35);
  static TextStyle get cardTitle =>
      _cairo(size: 15, weight: FontWeight.w600, height: 1.4);

  // النصوص
  static TextStyle get body =>
      _cairo(size: 14, weight: FontWeight.w400, height: 1.6);
  static TextStyle get bodyMedium =>
      _cairo(size: 14, weight: FontWeight.w500, height: 1.6);
  static TextStyle get caption => _cairo(
        size: 12.5,
        weight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );
  static TextStyle get label => _cairo(
        size: 12,
        weight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.2,
      );

  // الأرقام والمبالغ — واضحة وكبيرة
  static TextStyle get amountHero => _cairo(
        size: 34,
        weight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.5,
      );
  static TextStyle get amountXl => _cairo(
        size: 26,
        weight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.3,
      );
  static TextStyle get amountLg =>
      _cairo(size: 20, weight: FontWeight.w700, height: 1.25);
  static TextStyle get amountMd =>
      _cairo(size: 16, weight: FontWeight.w600, height: 1.3);
  static TextStyle get amountSm =>
      _cairo(size: 14, weight: FontWeight.w600, height: 1.3);
}

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final ColorScheme scheme = const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnDark,
      secondary: AppColors.accent,
      onSecondary: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.danger,
      onError: Colors.white,
      outline: AppColors.border,
      surfaceContainerHighest: AppColors.surfaceAlt,
    );

    final TextTheme baseText = GoogleFonts.cairoTextTheme(
      ThemeData.light().textTheme,
    ).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    final TextTheme textTheme = baseText.copyWith(
      displayLarge: baseText.displayLarge?.copyWith(fontWeight: FontWeight.w700),
      headlineMedium:
          baseText.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
      headlineSmall:
          baseText.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      titleLarge: baseText.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      titleMedium: baseText.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
      titleSmall: baseText.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13.5,
      ),
      bodyLarge: baseText.bodyLarge?.copyWith(fontSize: 15, height: 1.6),
      bodyMedium: baseText.bodyMedium?.copyWith(fontSize: 14, height: 1.6),
      bodySmall: baseText.bodySmall?.copyWith(
        fontSize: 12.5,
        height: 1.5,
        color: AppColors.textSecondary,
      ),
      labelLarge: baseText.labelLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,

      // ── Cards ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      // ── Buttons ───────────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.borderStrong,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          backgroundColor: AppColors.surface,
          side: const BorderSide(color: AppColors.border),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          highlightColor: AppColors.surfaceAlt,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        ),
      ),

      // ── Inputs ────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        floatingLabelStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.accent,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        prefixIconColor: AppColors.textMuted,
        suffixIconColor: AppColors.textMuted,
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.accent, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.danger, width: 1.6),
        ),
      ),

      // ── Misc ──────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceAlt,
        selectedColor: AppColors.accentSoft,
        labelStyle: textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.smAll),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppRadius.smAll,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: textTheme.bodySmall?.copyWith(color: Colors.white),
        waitDuration: const Duration(milliseconds: 400),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: const Color(0x1F0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdAll,
          side: const BorderSide(color: AppColors.border),
        ),
        textStyle: textTheme.bodyMedium,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primary,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        insetPadding: const EdgeInsets.all(AppSpacing.xxl),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.borderStrong),
        thickness: WidgetStateProperty.all(6),
        radius: const Radius.circular(AppRadius.pill),
        crossAxisMargin: 2,
      ),
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(AppColors.surfaceAlt),
        headingTextStyle: textTheme.titleSmall?.copyWith(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
        dataTextStyle: textTheme.bodyMedium,
        dividerThickness: 1,
        horizontalMargin: AppSpacing.xl,
        columnSpacing: AppSpacing.xxl,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
        linearTrackColor: AppColors.surfaceAlt,
      ),
    );
  }
}
