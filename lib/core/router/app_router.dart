import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:invygo/features/auth/presentation/screens/language_selector_screen.dart';
import '/features/app_shell/app_shell.dart';
import '/features/home/presentation/home_screen.dart';
import '/features/auth/presentation/screens/onboarding_screen.dart';
import '/features/auth/presentation/screens/login_screen.dart';
import '/features/auth/presentation/screens/register_screen.dart';
import '/features/auth/presentation/screens/register_provider_screen.dart';
import '/features/account/presentation/profile_screen.dart';
import '/features/settings/presentation/settings_screen.dart';
import '/core/router/app_router_paths.dart';
import '/core/router/go_router_refresh_stream.dart';
import '/core/di/locator.dart';
import '/shared/services/cache_manager.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/shared/models/role.dart';

GoRouter buildRouter(BuildContext context) {
  final auth = context.read<AuthCubit>();
  final cache = getIt<CacheManager>();

  String? redirectLogic(String loc) {
    final s = auth.state;

    // // 0) Auth bootstrap → show splash (prevents flicker)
    // final isBootstrapping = s is AuthInitial || s is AuthChecking;
    // if (isBootstrapping && loc != RouterPaths.splash) return RouterPaths.splash;

    // 1) Language first
    if (!cache.hasLanguage && loc != RouterPaths.languageSelector) return RouterPaths.languageSelector;

    // 2) Onboarding next
    if (cache.hasLanguage && !cache.hasSeenOnboarding && loc != RouterPaths.onboarding) {
      return RouterPaths.onboarding;
    }

    // 3) Auth/Role gates
    final isAuthed = s is Authenticated;
    final role = isAuthed ? s.role : null;
    final isProviderPath = loc.startsWith('/provider');
    final isNeutral = (loc == '/' ||
        loc == RouterPaths.splash ||
        loc == RouterPaths.languageSelector ||
        loc == RouterPaths.onboarding);

    // 3a) Provider area requires provider-auth
    if (isProviderPath) {
      if (!isAuthed) return RouterPaths.login;
      if (role == Role.provider) return RouterPaths.providerMain;
    }

    // 3b) If authed and hitting neutral/login, drop into role home
    if (isAuthed && (isNeutral || loc == RouterPaths.login)) {
      return (role == Role.provider) ? RouterPaths.providerHome : RouterPaths.userHome;
    }

    // 3c) If unauthed and hitting login is fine; user area is public → no redirect
    if (!isAuthed && loc == '/') return RouterPaths.userHome;

    return null;
  }

  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefresh(auth.stream),
    redirect: (ctx, state) => redirectLogic(state.uri.toString()),
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SizedBox()),
      // GoRoute(path: RouterPaths.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(path: RouterPaths.languageSelector, builder: (_, __) => const LanguageSelectorScreen()),
      GoRoute(path: RouterPaths.onboarding, builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: RouterPaths.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: RouterPaths.register, builder: (_, __) => const RegisterScreen()),
      GoRoute(path: RouterPaths.registerProvider, builder: (_, __) => const RegisterProviderScreen()),
      GoRoute(
        path: RouterPaths.providerMain,
        redirect: (_, __) => RouterPaths.providerHome,
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(state: state, child: child),
        routes: [
          GoRoute(path: RouterPaths.home, builder: (_, __) => const HomeScreen()),
          GoRoute(path: RouterPaths.providerHome, builder: (_, __) => const HomeScreen()),
          GoRoute(path: RouterPaths.profile, builder: (_, __) => const ProfileScreen()),
          GoRoute(path: RouterPaths.settings, builder: (_, __) => const SettingsScreen()),
        ],
      ),
    ],
  );
}
