import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A custom-styled, accessible button used across EcoSteps screens.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double? width;
  final String? tooltip;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.height = 54.0,
    this.width,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = isDark
        ? AppTheme.primaryGreen
        : AppTheme.primaryGreenDark;
    final defaultFg = isDark ? AppTheme.deepForest : Colors.white;

    final effectiveBg = backgroundColor ?? defaultBg;
    final effectiveFg = textColor ?? (isOutlined ? defaultBg : defaultFg);

    Widget buttonContent = Row(
      mainAxisSize: width == null ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: effectiveFg),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: effectiveFg,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );

    Widget buttonWidget;
    if (isOutlined) {
      buttonWidget = OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width ?? double.infinity, height),
          side: BorderSide(color: effectiveBg, width: 1.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        child: buttonContent,
      );
    } else {
      buttonWidget = ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: Size(width ?? double.infinity, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        child: buttonContent,
      );
    }

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: buttonWidget);
    }
    return buttonWidget;
  }
}
