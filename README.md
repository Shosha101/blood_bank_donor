# Blood Bank — Donor App

The **donor-facing app** of a two-app blood bank platform built with **Flutter**. Donors log in, browse blood donation requests, and respond to hospitals in need.

> 🏥 Companion app: [blood_bank_hospital](https://github.com/Shosha101/blood_bank_hospital) — the hospital-side dashboard.

## Features

- 🔐 **Login** with secure token storage (`flutter_secure_storage`)
- 🩸 **Donation requests** — browse and respond to active blood requests
- 👤 **Donor profile / about**
- 🌍 Localization-ready (`easy_localization`), responsive with side-menu layout for wide screens

## Architecture

Clean, feature-first structure with a fully typed networking layer:

- **Retrofit + Dio** code-generated API services, cookie-based session handling
- **`ApiResult` / error model with freezed** — every call returns a typed success/failure
- **Cubit (flutter_bloc)** state management with freezed states
- **get_it** dependency injection, centralized routing, shared theming

```
lib/
├── core/        # networking (dio factory, error handling), di, routing, theming
└── features/
    ├── login/
    ├── requests/
    └── about/
```

## Getting Started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```
