---
name: flutter-package-conventions
description: >-
  Conventions for maintaining the flutter_chips_input package.
  Use when modifying public API, updating versions, or preparing releases.
---

# Package Conventions

## Public API

- Only export through `lib/flutter_chips_input.dart`
- All implementation files live in `lib/src/`
- Never export `lib/src/` files directly

## Code Quality

- **Null safety**: All code must be null-safe (Dart >=2.12.0)
- **Linting**: Uses `package:flutter_lints/flutter.yaml` — run `flutter analyze --no-pub`
- **Formatting**: Run `dart format .` — CI enforces `dart format --set-exit-if-changed .`

## Versioning & Releases

1. Update version in `pubspec.yaml`
2. Add entry to `CHANGELOG.md` with format: `## [version] - DD-Mon-YYYY`
3. Use bullet list for changes under each version
4. Run full CI checks before release:
   ```bash
   flutter pub get
   dart format --set-exit-if-changed .
   flutter analyze --no-pub
   flutter test --no-pub --coverage
   ```

## CI Matrix

Tests run against Flutter stable, beta, and dev channels on macOS.
Ensure changes don't break across channels.
