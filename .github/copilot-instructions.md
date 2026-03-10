# Copilot Instructions for flutter_chips_input

## What This Package Does

A Flutter widget library that provides an input field with InputChip-based selection and autocomplete suggestions. The widget is generic (`ChipsInput<T>`) — consumers supply their own data type.

## Build, Test, and Lint

```bash
flutter pub get
flutter analyze --no-pub
flutter test --no-pub --coverage
flutter test --no-pub test/flutter_chips_input_test.dart   # single test file
```

Formatting check (CI enforces this):

```bash
dart format --set-exit-if-changed .
```

## Architecture

### Direct TextInputClient Implementation

`ChipsInputState<T>` implements `TextInputClient` directly rather than wrapping a `TextField`. It manages its own `TextInputConnection`, editing state, and cursor. This means text handling, focus management, and keyboard interaction are all manual — changes in these areas require understanding the Flutter text input protocol.

### Object Replacement Character Encoding

Chips are represented in the text editing value as Unicode object replacement characters (`0xFFFD`). The `TextEditingValue` extension in `chips_input.dart` separates "normal" typed text from replacement characters. The replacement character count determines how many chips exist; a decrease means a chip was deleted via keyboard.

### Suggestions Overlay

`SuggestionsBoxController` manages an `OverlayEntry` for the suggestions dropdown. The overlay position is computed relative to the input field and flips above the field when more space is available above. A `StreamController` broadcasts suggestion list updates to the overlay.

### Key Source Files

- `lib/src/chips_input.dart` — Main widget, state, and all input handling logic
- `lib/src/suggestions_box_controller.dart` — Overlay lifecycle for suggestions
- `lib/src/text_cursor.dart` — Custom blinking cursor widget

## Conventions

- **Null safety** is enabled (Dart SDK >=3.5.0 <4.0.0).
- Linting uses `package:flutter_lints/flutter.yaml` v6 (configured in `analysis_options.yaml`).
- The `example/` directory contains a standalone Flutter app demonstrating the widget with an `AppProfile` model class.
- The CI matrix tests against Flutter stable and beta channels.
