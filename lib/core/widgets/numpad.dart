import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// منطق إدخال المبالغ المشترك بين شاشات الدفع والورديات.
///
/// أول رقم بيتكتب بيمسح القيمة المبدئية (زي ماكينات الكاشير).
class AmountEntry {
  AmountEntry({double? initial})
      : text = initial == null ? '' : initial.toStringAsFixed(2),
        fresh = initial != null;

  String text;
  bool fresh;

  double get value => double.tryParse(text) ?? 0;
  bool get isEmpty => text.isEmpty;

  void tapKey(String key) {
    if (fresh) {
      text = '';
      fresh = false;
    }
    if (key == '.') {
      if (text.contains('.')) return;
      text = text.isEmpty ? '0.' : '$text.';
      return;
    }
    // خانتين عشريتين بالكتير
    final int dot = text.indexOf('.');
    if (dot != -1 && text.length - dot > 2) return;
    if (text.length >= 9) return;
    text = text == '0' ? key : '$text$key';
  }

  void backspace() {
    fresh = false;
    if (text.isNotEmpty) text = text.substring(0, text.length - 1);
  }

  void clear() {
    text = '';
    fresh = false;
  }

  void setValue(double v, {bool keepFresh = true}) {
    text = v.toStringAsFixed(2);
    fresh = keepFresh;
  }

  void add(double v) {
    final double base = fresh ? 0 : value;
    text = (base + v).toStringAsFixed(2);
    fresh = false;
  }
}

/// لوحة أرقام دائرية أنيقة.
class Numpad extends StatelessWidget {
  const Numpad({
    super.key,
    required this.onKey,
    required this.onBackspace,
    this.keySize = 62,
    this.spacing = 10,
  });

  final ValueChanged<String> onKey;
  final VoidCallback onBackspace;
  final double keySize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    const List<String> keys = <String>[
      '1', '2', '3', //
      '4', '5', '6', //
      '7', '8', '9', //
      '.', '0', '<', //
    ];

    // الأرقام بتترتب من اليسار زي أي آلة حاسبة حتى في الواجهة العربية
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: keySize * 3 + spacing * 2,
        child: Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          children: <Widget>[
            for (final String k in keys)
              _NumpadKey(
                size: keySize,
                label: k == '<' ? null : k,
                icon: k == '<' ? Icons.backspace_outlined : null,
                onTap: () => k == '<' ? onBackspace() : onKey(k),
              ),
          ],
        ),
      ),
    );
  }
}

class _NumpadKey extends StatefulWidget {
  const _NumpadKey({
    required this.size,
    required this.onTap,
    this.label,
    this.icon,
  });

  final double size;
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  State<_NumpadKey> createState() => _NumpadKeyState();
}

class _NumpadKeyState extends State<_NumpadKey> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.93 : 1,
          duration: const Duration(milliseconds: 110),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: _hovered ? AppColors.accentSoft : AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: _hovered ? AppColors.accent : AppColors.border,
                width: _hovered ? 1.5 : 1,
              ),
              boxShadow: _pressed ? null : AppShadows.soft,
            ),
            alignment: Alignment.center,
            child: widget.icon != null
                ? Icon(
                    widget.icon,
                    size: widget.size * 0.35,
                    color: _hovered
                        ? AppColors.accent
                        : AppColors.textSecondary,
                  )
                : Text(
                    widget.label!,
                    style: AppText.amountLg.copyWith(
                      fontSize: widget.size * 0.37,
                      color: _hovered
                          ? AppColors.accent
                          : AppColors.textPrimary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
