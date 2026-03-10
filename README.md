# flutter_chips_input

[![CI](https://github.com/danvick/flutter_chips_input/workflows/CI/badge.svg)](https://github.com/danvick/flutter_chips_input/actions)
[![pub package](https://img.shields.io/pub/v/flutter_chips_input.svg)](https://pub.dev/packages/flutter_chips_input)

A Flutter widget that builds an input field with `InputChip`s and autocomplete suggestions. The widget is generic — supply your own data type `T` and it handles chips, text input, and suggestion overlay for you.

<img src="https://raw.githubusercontent.com/nicholasnm/flutter_chips_input/refs/heads/master/example/flutter_chips_input.gif" width="300" />

## Requirements

| Dependency | Version          |
| ---------- | ---------------- |
| Dart SDK   | >= 3.5.0 < 4.0.0 |
| Flutter    | >= 3.24.0        |

## Installation

```yaml
dependencies:
  flutter_chips_input: ^3.0.0
```

```bash
flutter pub get
```

## Usage

```dart
import 'package:flutter_chips_input/flutter_chips_input.dart';

ChipsInput<String>(
  initialValue: const ['Jane Doe'],
  decoration: const InputDecoration(labelText: 'Select People'),
  findSuggestions: (query) {
    final contacts = ['John Doe', 'Jane Doe', 'John Smith', 'Jane Smith'];
    if (query.isEmpty) return contacts;
    return contacts
        .where((c) => c.toLowerCase().contains(query.toLowerCase()))
        .toList();
  },
  onChanged: (values) => debugPrint('$values'),
  chipBuilder: (context, state, value) => InputChip(
    label: Text(value),
    onDeleted: () => state.deleteChip(value),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  ),
  suggestionBuilder: (context, state, value) => ListTile(
    title: Text(value),
    onTap: () => state.selectSuggestion(value),
  ),
)
```

## Parameters

| Parameter                | Type                              | Default                    | Description                                       |
| ------------------------ | --------------------------------- | -------------------------- | ------------------------------------------------- |
| `chipBuilder`            | `ChipsBuilder<T>` **(required)**  | —                          | Builds an `InputChip` for each selected value      |
| `suggestionBuilder`      | `ChipsBuilder<T>` **(required)**  | —                          | Builds a widget for each autocomplete suggestion   |
| `findSuggestions`        | `ChipsInputSuggestions<T>` **(required)** | —                  | Returns suggestions (sync or `Future`)             |
| `onChanged`              | `ValueChanged<List<T>>` **(required)** | —                     | Called when the chip list changes                   |
| `initialValue`           | `List<T>`                         | `[]`                       | Pre-selected chips                                 |
| `decoration`             | `InputDecoration`                 | `InputDecoration()`        | Decoration for the input field                     |
| `enabled`                | `bool`                            | `true`                     | Whether the input is interactive                   |
| `maxChips`               | `int?`                            | `null`                     | Maximum number of chips allowed                    |
| `textStyle`              | `TextStyle?`                      | `null`                     | Style for the typed text                           |
| `suggestionsBoxMaxHeight`| `double?`                         | `null`                     | Max height of the suggestions dropdown             |
| `inputType`              | `TextInputType`                   | `TextInputType.text`       | Keyboard type                                      |
| `inputAction`            | `TextInputAction`                 | `TextInputAction.done`     | Keyboard action button                             |
| `keyboardAppearance`     | `Brightness`                      | `Brightness.light`         | Keyboard brightness (iOS)                          |
| `textCapitalization`     | `TextCapitalization`              | `TextCapitalization.none`  | Text capitalization behavior                       |
| `autofocus`              | `bool`                            | `false`                    | Auto-focus on widget mount                         |
| `allowChipEditing`       | `bool`                            | `false`                    | Restore typed text when deleting a chip            |
| `focusNode`              | `FocusNode?`                      | `null`                     | External focus control                             |
| `initialSuggestions`     | `List<T>?`                        | `null`                     | Suggestions shown on initial focus                 |
| `obscureText`            | `bool`                            | `false`                    | Obscure the typed text                             |
| `autocorrect`            | `bool`                            | `true`                     | Enable autocorrect                                 |
| `actionLabel`            | `String?`                         | `null`                     | Custom label for keyboard action                   |
| `textOverflow`           | `TextOverflow`                    | `TextOverflow.clip`        | Overflow behavior of typed text                    |

## Programmatic Control

Access the state via a `GlobalKey` to add chips or request focus:

```dart
final chipKey = GlobalKey<ChipsInputState>();

// Add a chip
chipKey.currentState?.selectSuggestion('New Value');

// Delete a chip
chipKey.currentState?.deleteChip('Old Value');

// Open keyboard
chipKey.currentState?.requestKeyboard();
```

## Development

```bash
# Install dependencies
flutter pub get

# Lint (strict — zero issues required)
flutter analyze --no-pub --fatal-infos

# Format
dart format --set-exit-if-changed .

# Test with coverage
flutter test --no-pub --coverage

# Run example
cd example && flutter run
```

## License

[MIT](LICENSE) — Originally created by [Danvick Miller](https://github.com/danvick).