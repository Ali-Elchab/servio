import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/shared/extensions/context_extensions.dart';
import '/shared/widgets/custom_button.dart';

Future confirmDialog(
  BuildContext context, {
  required String text,
  String yes = "ui.yes",
  String no = "ui.no",
  double blurStrength = 0.0,
  double? width,
  double? height,
  bool barrierDismissible = false,
}) {
  return showDialog(
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.6),
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: height ?? 160, // Default height
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // X Button at top-right
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: const Icon(Icons.close, size: 18),
                    onTap: () {
                      if (yes == context.tr("View Order")) {
                        context.pop();
                        context.pop(true);
                      } else {
                        context.pop(context);
                      }
                    },
                  ),
                ],
              ),
              // Dialog text
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Yes button
                  CustomButton(
                    onPressed: () {
                      context.pop(true);
                    },
                    text: context.tr(yes),
                  ),
                  const SizedBox(width: 8),

                  no == ""
                      ? const SizedBox()
                      : CustomButton(
                          onPressed: () {
                            context.pop(false);
                          },
                          text: context.tr(no),
                        ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
