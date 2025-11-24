import 'package:get_it/get_it.dart';
import '/shared/services/connectivity_service.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/shared/db/daos/providers_dao.dart';
import '/shared/db/daos/company_dao.dart';
import '/shared/db/daos/user_dao.dart';
import '/shared/db/daos/categories_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/features/auth/data/remote/auth_remote_source.dart';
import '/features/auth/data/repositories/auth_repository.dart';
import '/features/providers/data/remote/providers_remote_source.dart';
import '/features/providers/data/repositories/providers_repository.dart';
import '/features/categories/data/remote/categories_remote_source.dart';
import '/features/categories/data/repositories/categories_repository.dart';
import '../../shared/db/app_db.dart';
import '../../shared/services/cache_manager.dart';
import '../../shared/services/api_service.dart';

// locator.dart
final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Connectivity
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityServiceImpl());

  // DB
  getIt.registerSingletonAsync<AppDb>(() async => await AppDb.make());
  await getIt.isReady<AppDb>();

  // DAOs
  getIt.registerLazySingleton<UserDao>(() => UserDao(getIt<AppDb>()));
  getIt.registerLazySingleton<CompanyDao>(() => CompanyDao(getIt<AppDb>()));
  getIt.registerLazySingleton<ProvidersDao>(() => ProvidersDao(getIt<AppDb>()));
  getIt.registerLazySingleton<CategoriesDao>(() => CategoriesDao(getIt<AppDb>()));

  // Prefs -> Cache
  getIt.registerSingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  await getIt.isReady<SharedPreferences>();

  getIt.registerLazySingleton<CacheManager>(() => CacheManager(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(
        getIt<AuthRepository>(),
        getIt<CacheManager>(),
        getIt<ApiService>(),
      ));

  // API + repo
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<CacheManager>(), getIt<ConnectivityService>()));
  getIt.registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSource(getIt<ApiService>()));
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(getIt<AuthRemoteSource>(), getIt<CacheManager>(), getIt<UserDao>(), getIt<CompanyDao>()));

  getIt.registerLazySingleton<ProvidersRemoteSource>(() => ProvidersRemoteSource(getIt<ApiService>(), getIt<CacheManager>()));
  getIt.registerLazySingleton<ProvidersRepository>(() => ProvidersRepository(
        providersDao: getIt<ProvidersDao>(),
        remote: getIt<ProvidersRemoteSource>(),
        cache: getIt<CacheManager>(),
      ));

  getIt.registerLazySingleton<CategoriesRemoteSource>(() => CategoriesRemoteSource(getIt<ApiService>()));
  getIt.registerLazySingleton<CategoriesRepository>(() => CategoriesRepository(
        categoriesDao: getIt<CategoriesDao>(),
        remote: getIt<CategoriesRemoteSource>(),
        cache: getIt<CacheManager>(),
      ));
}
