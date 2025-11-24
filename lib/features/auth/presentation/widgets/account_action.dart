import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/theme/app_colors.dart';

class AccountAction extends StatelessWidget {
  final String route;
  final String text;
  final String action;
  const AccountAction({super.key, required this.route, required this.text, required this.action});

  void _navigate(BuildContext context) {
    // Reset the state before navigating to the sign-up page
    context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => _navigate(context),
          child: Text(
            action,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
          ),
        ),
      ],
    );
  }
}
