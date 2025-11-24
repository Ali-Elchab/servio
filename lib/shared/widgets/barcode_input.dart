import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

/// Generic barcode input field that provides scan & clear adornments.
class BarcodeInput extends StatelessWidget {
  const BarcodeInput({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onScanPressed,
    required this.labelText,
    required this.scanTooltip,
    required this.clearTooltip,
    this.palette = AppColors.brandPalette,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onScanPressed;
  final String labelText;
  final String scanTooltip;
  final String clearTooltip;
  final FeaturePalette palette;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: palette.primary,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: palette.primary),
        ),
        labelStyle: TextStyle(color: palette.primary),
        prefixIcon: IconButton(
          icon: const Icon(Icons.qr_code_scanner_rounded),
          tooltip: scanTooltip,
          onPressed: onScanPressed,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => controller.clear(),
          tooltip: clearTooltip,
        ),
      ),
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.done,
    );
  }
}
