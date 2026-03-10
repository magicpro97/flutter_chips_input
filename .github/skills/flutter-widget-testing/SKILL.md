---
name: flutter-widget-testing
description: >-
  Guide for writing and running Flutter widget tests for the ChipsInput widget library.
  Use when asked to write tests, add test coverage, or verify widget behavior.
---

# Flutter Widget Testing for ChipsInput

## Context

This is a Flutter widget library (`flutter_chips_input`). The main widget `ChipsInput<T>`
is generic and implements `TextInputClient` directly (not wrapping TextField).

## Instructions

1. Test files go in `test/` directory, named `*_test.dart`
2. Always wrap the widget under test in `MaterialApp` > `Scaffold` > widget
3. `ChipsInput<T>` requires these builder callbacks:
   - `chipBuilder`: Returns an `InputChip` for each selected item
   - `suggestionBuilder`: Returns a `ListTile` for each suggestion
   - `findSuggestions`: Async function returning filtered suggestions
   - `onChanged`: Callback when chips list changes
4. Use `tester.pumpWidget()` then `tester.pump()` after interactions
5. Run all tests: `flutter test --no-pub`
6. Run single file: `flutter test --no-pub test/<file>_test.dart`
7. Run with coverage: `flutter test --no-pub --coverage`

## Test Template

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

void main() {
  const testItems = ['Alpha', 'Beta', 'Gamma', 'Delta'];

  Widget buildChipsInput({
    List<String> initialValue = const [],
    int? maxChips,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ChipsInput<String>(
          initialValue: initialValue,
          maxChips: maxChips,
          findSuggestions: (query) => query.isNotEmpty
              ? testItems.where((i) => i.toLowerCase().contains(query.toLowerCase())).toList()
              : [],
          onChanged: (chips) {},
          chipBuilder: (context, state, data) => InputChip(
            key: ValueKey(data),
            label: Text(data),
            onDeleted: () => state.deleteChip(data),
          ),
          suggestionBuilder: (context, state, data) => ListTile(
            key: ValueKey(data),
            title: Text(data),
            onTap: () => state.selectSuggestion(data),
          ),
        ),
      ),
    );
  }

  testWidgets('renders initial chips', (tester) async {
    await tester.pumpWidget(buildChipsInput(initialValue: ['Alpha', 'Beta']));
    expect(find.text('Alpha'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
  });
}
```
