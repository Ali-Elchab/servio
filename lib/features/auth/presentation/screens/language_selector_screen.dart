import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/app_assets.dart';
import '/core/router/app_router_paths.dart';
import '/shared/cubits/locale/locale_cubit.dart';
import '/shared/extensions/context_extensions.dart';

class LanguageSelectorScreen extends StatelessWidget {
  const LanguageSelectorScreen({super.key});

  Future<void> _setLocale(BuildContext context, Locale locale) async {
    await context.read<LocaleCubit>().changeLocale(locale);
    if (!context.mounted) return;
    context.go(RouterPaths.login);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final primary = colors.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.logoNoBg, width: 120, height: 120),
                const SizedBox(height: 8),
                Text(
                  "Let's Get Started",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: primary),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Language',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    _LanguageButton(
                      label: 'English',
                      flagAsset: AppAssets.englishLangIcon,
                      onTap: () => _setLocale(context, const Locale('en')),
                    ),
                    const SizedBox(height: 12),
                    _LanguageButton(
                      label: 'العربية',
                      flagAsset: AppAssets.arabicLangIcon,
                      onTap: () => _setLocale(context, const Locale('ar')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.label,
    required this.flagAsset,
    required this.onTap,
  });

  final String label;
  final String flagAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final primary = colors.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
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
            Image.asset(flagAsset, width: 28, height: 20, fit: BoxFit.cover),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: primary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
