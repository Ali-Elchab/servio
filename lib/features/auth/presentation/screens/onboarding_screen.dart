import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/app_assets.dart';
import '/core/router/app_router_paths.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_text.dart';
import '/shared/cubits/locale/locale_cubit.dart';
import '/shared/extensions/context_extensions.dart';
import '/shared/services/cache_manager.dart';
import '/shared/widgets/custom_button.dart';
import '/core/di/locator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _completeOnboarding(BuildContext context, String path) async {
    await getIt<CacheManager>().setHasSeenOnboarding(true);
    if (!context.mounted) return;
    context.go(path);
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.select((LocaleCubit c) => c.state);
    final isAr = locale.languageCode == "ar";
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextButton(
              onPressed: () => _completeOnboarding(context, RouterPaths.login),
              child: Text(
                context.tr('actions.skip'),
                style: AppText.titleMedium(context).copyWith(
                  decoration: TextDecoration.underline,
                  color: colors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 70.0, right: 70, bottom: 48, top: 28),
          child: Column(
            children: [
              Image.asset(AppAssets.logo, height: 150),
              const Spacer(),
              const SizedBox(height: 48),
              Align(
                alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: isAr ? TextAlign.end : TextAlign.start,
                      text: TextSpan(
                        style: AppText.displayMedium(context).copyWith(color: colors.primary, fontWeight: FontWeight.w300),
                        children: isAr
                            ? [
                                const TextSpan(text: "صُممنا لنخدمك.\nخُلِقنا لراحتك\n"),
                                TextSpan(
                                  text: "نحن الحل.\n",
                                  style: AppText.displayMedium(context).copyWith(color: colors.secondary, fontWeight: FontWeight.w700),
                                ),
                                const TextSpan(text: "دائمًا."),
                              ]
                            : [
                                const TextSpan(text: "Built to\nhelp.\nBuilt to\n"),
                                TextSpan(
                                  text: "Servio.",
                                  style: AppText.displayMedium(context).copyWith(color: colors.secondary, fontWeight: FontWeight.w700),
                                ),
                              ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                text: context.tr('auth.buttons.login'),
                onPressed: () => _completeOnboarding(context, RouterPaths.login),
                isFill: false,
                color: colors.secondary,
              ),
              const SizedBox(height: 48),
              GestureDetector(
                onTap: () => _completeOnboarding(context, RouterPaths.register),
                child: Text(
                  context.tr('auth.buttons.signUp'),
                  style: AppText.bodyMedium(context).copyWith(
                    fontWeight: FontWeight.w400,
                    color: colors.secondary,
                    decoration: TextDecoration.underline,
                    decorationColor: colors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
