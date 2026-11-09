# Servio

Flutter app for a service-provider directory: people find local providers by category and location. It talks to the Laravel API in [servio_server](https://github.com/Ali-Elchab/servio_server).

**Status:** in development, not launched.

## What the app has today

- Onboarding and language selection (Arabic and English)
- Customer sign-up, provider sign-up, login and guest mode
- Home screen with categories and providers
- Profile and settings
- Local Drift (SQLite) cache and a typed API layer

## Still to build in the app

Provider detail screen, ratings, favorites and search by location. The API already supports ratings, favorites, media and radius search.

## Stack

Flutter, Dart, Cubit/Bloc, GoRouter, GetIt, Dio, Drift, flutter_screenutil

## Structure

```text
lib/
  core/       config, constants, DI, errors, localization, router, theme
  features/   auth, home, categories, providers, account, settings, app_shell
  shared/     cubits, local database, models, services, widgets
```

## Run it

1. Start the API from `servio_server` and note its URL.
2. Set `baseUrl` and `servioKey` in `lib/core/constants/app_constants.dart`. `servioKey` must match `SERVIO_KEY` on the server.
3. Run:

```bash
flutter pub get
flutter run
```

## Notes

`baseUrl` points to a local network address and `servioKey` is a constant in the source. Use your own values, and move them to `--dart-define` before building for release.
