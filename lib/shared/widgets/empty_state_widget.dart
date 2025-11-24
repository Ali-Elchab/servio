import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/router/app_router_paths.dart';
import '/shared/widgets/custom_button.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String title;
  final String buttonText;
  final double? buttonWidth;
  final Icon icon;

  /// Provide a refresh callback to enable pull-to-refresh.
  final Future<void> Function()? onRefresh;

  const EmptyStateWidget({
    super.key,
    required this.message,
    required this.title,
    required this.buttonText,
    required this.icon,
    this.buttonWidth,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            buttonText != ''
                ? CustomButton(
                    width: buttonWidth ?? 250,
                    text: buttonText,
                    onPressed: () async {
                      if (onRefresh != null) {
                        await onRefresh!();
                      } else {
                        // Fallback navigation if no refresh handler provided
                        if (context.mounted) context.pushReplacement(RouterPaths.home);
                      }
                    },
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );

    // If no onRefresh provided, just return the content.
    if (onRefresh == null) return content;

    // Wrap with RefreshIndicator; SingleChildScrollView + AlwaysScrollable so it can be pulled even if short.
    return RefreshIndicator(
      onRefresh: onRefresh!,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            // Ensure it can stretch to full height so pull works from anywhere.
            minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
          ),
          child: content,
        ),
      ),
    );
  }
}
