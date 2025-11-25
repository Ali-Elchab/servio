import 'package:flutter/material.dart';
import 'package:invygo/shared/extensions/context_extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFill;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? color;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFill = true,
    this.icon,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color btnColor = color ?? context.colors.secondary;
    final Color bgColor = isFill ? btnColor : Colors.transparent;
    final Color txtColor = isFill ? Theme.of(context).colorScheme.onPrimary : AppColors.primary;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.secondary, width: isFill ? 0 : 2),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Theme.of(context).colorScheme.onPrimary),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: txtColor),
                    const SizedBox(width: 8),
                  ],
                  Text(text,
                      style: AppText.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: txtColor,
                      )),
                ],
              ),
      ),
    );
  }
}
