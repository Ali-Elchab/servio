import 'dart:io';

import 'package:get_it/get_it.dart';
import '/shared/db/app_db.dart';
import '/shared/services/cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<void> devResetAll() async {
  // close DB
  final db = GetIt.I<AppDb>();
  await db.close();

  // delete DB file
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'Servio.db'));
  if (await file.exists()) {
    await file.delete();
  }

  // clear cache (token, userId, onboarding, etc.)
  final cache = GetIt.I<CacheManager>();
  await cache.clearTokenAndUser();
  await cache.setIsLoggedIn(false);
  await cache.setHasSeenOnboarding(false); // if you have this

  // (Optional) re-init DB
  GetIt.I.unregister<AppDb>();
  final freshDb = await AppDb.make();
  GetIt.I.registerSingleton<AppDb>(freshDb);
}
