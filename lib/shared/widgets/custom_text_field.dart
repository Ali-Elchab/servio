import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/theme/app_colors.dart';
import '/shared/extensions/context_extensions.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final IconData? icon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool isBig;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
    this.icon,
    this.validator,
    this.onChanged,
    this.isBig = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    final textDirection = _getTextDirection(widget.controller.text, Directionality.of(context));

    return SizedBox(
      height: widget.isBig ? 100 : 42.h,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        textDirection: textDirection,
        maxLines: widget.isBig ? 4 : 1,
        validator: (value) {
          final result = widget.validator?.call(value);
          setState(() => hasError = result != null);
          return result;
        },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          hintText: widget.hintText,
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
          suffixIcon: hasError
              ? Tooltip(
                  message: "${widget.hintText} ${context.tr('ui.isRequired')}",
                  child: Icon(Icons.error_outline, color: Colors.red.shade700),
                )
              : widget.isPassword
                  ? IconButton(
                      icon:
                          Icon(widget.obscureText ? Icons.visibility_off : Icons.visibility, color: AppColors.primary),
                      onPressed: widget.onToggleVisibility,
                    )
                  : null,
        ),
      ),
    );
  }

  TextDirection _getTextDirection(String text, TextDirection fallback) {
    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    return text.trim().isEmpty ? fallback : (hasArabic ? TextDirection.rtl : TextDirection.ltr);
  }
}
