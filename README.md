# Dogshop — Dog Food Shop

A Flutter demo app for browsing and buying dog food. This repository contains the app source and basic scripts to build, run, and test the project on Windows, web (Chrome), and mobile emulators.

## Prerequisites

- Flutter SDK (stable) installed and on your PATH — https://docs.flutter.dev/get-started/install
- For Windows desktop builds: Visual Studio (with C++ workload) installed and configured — see Flutter docs.
- For Android: Android Studio or Android SDK + an emulator or device.
- For iOS/macOS builds: Xcode (macOS only).
- A code editor such as VS Code or Android Studio is recommended.

Verify your environment with:

```pwsh
flutter doctor -v
```

## Clone the repository

```pwsh
git clone https://github.com/charlsrebaja/Dogshop-app.git
cd Dogshop-app
```

## Install dependencies

```pwsh
flutter pub get
```

## Run the app

Letting Flutter pick a device (recommended when you have multiple targets available):

```pwsh
flutter run
```

Or target a specific device:

- Run on Windows desktop:
```pwsh
flutter run -d windows
```

- Run on Chrome (web):
```pwsh
flutter run -d chrome
```

- Run on an Android emulator (ensure an emulator is running) or device:
```pwsh
flutter run -d <device-id>
```

During a running debug session you can use the following keys in the terminal:

- `r` — hot reload
- `R` — full restart
- `d` — detach (stop flutter run but leave app running)

## Tests

Run the project's automated tests with:

```pwsh
flutter test
```

## Build release artifacts

- Build Windows (release):
```pwsh
flutter build windows --release
```

- Build web (release):
```pwsh
flutter build web --release
```

- Build Android (release APK):
```pwsh
flutter build apk --release
```

See Flutter docs for signing and publishing mobile apps.

## Project structure (high level)

- `lib/main.dart` — app entry point
- `lib/pages/` — application pages (home, login, product details, cart, profile, etc.)
- `lib/widgets/` — reusable widgets (product cards, snackbars, badges)
- `lib/services/` — services like `cart_service.dart`
- `assets/` — images and other static assets

## Troubleshooting

- If `flutter run` lists devices but you get build failures, run `flutter doctor -v` and fix the reported issues.
- For web: if the browser closes immediately, keep the DevTools/ browser tab open and watch the terminal for logs.
- If you add native plugins, run `flutter pub get` and then rebuild the app (clean if needed):

```pwsh
flutter clean
flutter pub get
flutter run
```

## Contributing

Contributions are welcome. Open an issue or submit a pull request with a clear description of the change and a small, focused diff.

## License

This project does not specify a license. If you plan to publish or share, consider adding a license (for example, MIT or Apache-2.0).

---

If you'd like, I can add a short troubleshooting checklist, CI config, or a CONTRIBUTING.md next. Tell me which platform you'd like me to verify the run on (Windows, Chrome/web, Android emulator) and I can run a quick smoke test and report results.
