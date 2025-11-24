import 'package:flutter/material.dart';
import '/shared/extensions/context_extensions.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = const Color.fromARGB(239, 76, 175, 79),
  IconData? icon,
  String? actionLabel,
  VoidCallback? onActionPressed,
  bool hasFAB = false,
}) {
  if (message.isEmpty) return;

  final bool isFixed = hasFAB;

  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: isFixed ? null : MediaQuery.of(context).size.width * 0.8,
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: isFixed ? SnackBarBehavior.fixed : SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: isFixed ? 2 : 0),
        child: Row(
          children: [
            if (icon != null) ...[Icon(icon, color: Colors.white, size: 22), const SizedBox(width: 8)],
            Expanded(
              child: Text(
                context.tr(message),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  onActionPressed();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color.fromRGBO(255, 255, 255, 0.2)),
                  child: Text(
                    actionLabel.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
