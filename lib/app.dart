import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '/shared/cubits/locale/locale_cubit.dart';
import '/shared/cubits/theme/theme_cubit.dart';
import '/core/constants/app_globals.dart';
import '/core/constants/app_constants.dart';
import '/core/router/app_router.dart';
import '/core/theme/theme.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = buildRouter(context);
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.select((LocaleCubit c) => c.state);
    final themestate = context.select((ThemeCubit c) => c.state);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          themeMode: themestate.mode,
          theme: buildAppTheme(isDark: false),
          darkTheme: buildAppTheme(isDark: true),
          routerConfig: _router,
          scaffoldMessengerKey: scaffoldMessenger,
          locale: locale,
          localizationsDelegates: AppConstants.localizationsDelegates,
          supportedLocales: AppConstants.supportedLocales,
          localeResolutionCallback: AppConstants.localeResolutionCallback,
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            ScreenUtil.ensureScreenSize();
            return widget!;
          },
        );
      },
    );
  }
}
