import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

GoRouter buildRouter(BuildContext context) {
  final auth = context.read<AuthCubit>();
  final cache = getIt<CacheManager>();

  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefresh(auth.stream),
    redirect: (ctx, state) {
      final loc = state.matchedLocation;
      final s = auth.state;

      final seen = cache.hasSeenOnboardingMem;
      if (!seen && loc != RouterPaths.onboarding) return RouterPaths.onboarding;

      final isChecking = s is AuthInitial || s is AuthChecking;
      if (isChecking) return null;

      final authed = s is Authenticated;
      const public = {
        RouterPaths.login,
        RouterPaths.register,
        RouterPaths.onboarding,
      };

      if (loc == '/') return authed ? RouterPaths.home : RouterPaths.login;

      if (!authed && !public.contains(loc)) return RouterPaths.login;
      if (authed && public.contains(loc)) return RouterPaths.home;

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SizedBox()),
      GoRoute(path: RouterPaths.onboarding, builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: RouterPaths.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: RouterPaths.register, builder: (_, __) => const RegisterScreen()),
      GoRoute(path: RouterPaths.registerProvider, builder: (_, __) => const RegisterProviderScreen()),
      ShellRoute(
        builder: (context, state, child) => AppShell(state: state, child: child),
        routes: [
          GoRoute(path: RouterPaths.home, builder: (_, __) => const HomeScreen()),
          GoRoute(path: RouterPaths.profile, builder: (_, __) => const ProfileScreen()),
          GoRoute(path: RouterPaths.settings, builder: (_, __) => const SettingsScreen()),
        ],
      ),
    ],
  );
}
