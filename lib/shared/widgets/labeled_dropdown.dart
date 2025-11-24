import 'package:flutter/material.dart';

/// Reusable labeled dropdown with optional loading and error states.
class LabeledDropdown<T> extends StatelessWidget {
  const LabeledDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    this.loading = false,
    this.loadingText,
    this.errorText,
    this.onRetry,
    this.menuMaxHeight,
    this.icon,
    this.dropdownColor,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Widget? hint;
  final bool loading;
  final String? loadingText;
  final String? errorText;
  final VoidCallback? onRetry;
  final double? menuMaxHeight;
  final Widget? icon;
  final Color? dropdownColor;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final smallText = theme.textTheme.bodySmall?.copyWith(fontSize: 11.0);

    Widget child;
    if (loading) {
      child = Row(
        children: [
          const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          const SizedBox(width: 8),
          Text(loadingText ?? '', style: smallText),
        ],
      );
    } else if (errorText != null) {
      child = InkWell(
        onTap: onRetry,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Icon(Icons.error_outline, size: 16, color: colors.error),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  errorText!,
                  style: smallText?.copyWith(color: colors.error),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      child = DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          items: items,
          hint: hint,
          icon: icon ?? const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
          menuMaxHeight: menuMaxHeight,
          dropdownColor: dropdownColor,
          onChanged: onChanged,
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary.withOpacity((value != null) ? 0.06 : 0.03),
            colors.surfaceVariant.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: smallText?.copyWith(color: colors.onSurfaceVariant, fontSize: 14),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          border: InputBorder.none,
        ),
        child: child,
      ),
    );
  }
}
