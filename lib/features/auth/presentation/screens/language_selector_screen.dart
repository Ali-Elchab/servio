import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/app_assets.dart';
import '/core/router/app_router_paths.dart';
import '/core/theme/app_text.dart';
import '/shared/cubits/locale/locale_cubit.dart';
import '/shared/extensions/context_extensions.dart';

class LanguageSelectorScreen extends StatelessWidget {
  const LanguageSelectorScreen({super.key});

  Future<void> _setLocale(BuildContext context, Locale locale) async {
    await context.read<LocaleCubit>().changeLocale(locale);
    if (!context.mounted) return;
    context.go(RouterPaths.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final primary = colors.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.fullLogo,
                    width: 100.w,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Let's Get Started",
                    style: AppText.titleMedium(context).copyWith(color: primary, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Container(
                height: 300.h,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(60, 40, 60, 40),
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, -4)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select Language',
                      style: AppText.titleMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 18),
                    _LanguageButton(
                      label: 'English',
                      flagEmoji: '🇺🇸',
                      onTap: () => _setLocale(context, const Locale('en')),
                    ),
                    const SizedBox(height: 12),
                    _LanguageButton(
                      label: 'العربية',
                      flagEmoji: '🇱🇧',
                      onTap: () => _setLocale(context, const Locale('ar')),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.label,
    required this.flagEmoji,
    required this.onTap,
  });

  final String label;
  final String flagEmoji;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final primary = colors.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.secondary, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(flagEmoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppText.titleSmall(context).copyWith(color: primary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
