# 🚀 Flutter Starter Kit

A production-ready Flutter starter kit designed for scalable apps with clean architecture, Riverpod state management, Drift local persistence, and GoRouter navigation. Flexible enough for any type of app (e-commerce, SaaS, sales, etc.).

---

## ✨ Features

- **Clean Architecture** with separation into `core/`, `data/`, `features/`, `shared/`
- **Authentication flow** with sealed `AuthState` (`AuthChecking`, `Authenticated`, `Unauthenticated`, `AuthGuest`)
- **Local bootstrap** from cache + Drift DB
- **Navigation** via GoRouter with redirects for auth, language, onboarding
- **Persistence** with Drift (products, customers, invoices, users)
- **Error handling** using `AppException` + strongly typed `Result<T>`
- **UI/UX**: responsive with `flutter_screenutil`, shared widgets, light/dark themes
- **Internationalization** with localization extension
- **Extensible** feature-first structure

---

## 📂 Folder Structure

lib/
├─ app.dart # Root widget
├─ main.dart # Entry point
│
├─ core/ # Config, router, theme, constants
├─ data/ # Local DB (Drift), remote services, repositories, models
├─ features/ # Feature modules (auth, products, customers, etc.)
├─ shared/ # Common widgets, providers, services, extensions
