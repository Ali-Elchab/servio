import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/auth/data/repositories/auth_repository.dart';
import '/shared/cubits/locale/locale_cubit.dart';
import '/core/di/locator.dart';
import '/shared/cubits/theme/theme_cubit.dart';
import '/shared/services/cache_manager.dart';
import '/shared/services/api_service.dart';
import '/app.dart';
import '/features/providers/cubit/providers_cubit.dart';
import '/features/providers/data/repositories/providers_repository.dart';
import '/features/categories/cubit/categories_cubit.dart';
import '/features/categories/data/repositories/categories_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(getIt<CacheManager>())),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => AuthCubit(getIt<AuthRepository>(), getIt<CacheManager>(), getIt<ApiService>())),
        BlocProvider(create: (_) => ProvidersCubit(getIt<ProvidersRepository>())),
        BlocProvider(create: (_) => CategoriesCubit(getIt<CategoriesRepository>())),
      ],
      child: const MainApp(),
    ),
  );
}
