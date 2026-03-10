---
name: text-input-client-pattern
description: >-
  Guide for working with the custom TextInputClient implementation in ChipsInput.
  Use when modifying text input handling, keyboard interaction, or chip encoding.
---

# TextInputClient Architecture

## Overview

`ChipsInputState<T>` implements `TextInputClient` directly instead of using `TextField`.
This means all text input, focus, and keyboard management is manual.

## Object Replacement Character Encoding

- Each chip is represented as Unicode character `U+FFFD` (constant `kObjectReplacementChar`) in the `TextEditingValue`
- `_value.normalCharactersText` extracts user-typed text (excludes replacement chars)
- `_value.replacementCharactersCount` gives the current chip count
- When replacement count decreases → a chip was deleted via keyboard backspace

## Key Methods

| Method | Purpose |
|--------|---------|
| `selectSuggestion(T data)` | Add a chip programmatically |
| `deleteChip(T data)` | Remove a chip |
| `_updateTextInputState()` | Sync internal state with platform text input |
| `_onSearchChanged(String)` | Search with `_searchId` for race condition protection |
| `_openInputConnection()` | Attach to platform text input |
| `_closeInputConnectionIfNeeded()` | Detach from platform text input |

## Caution Areas

- `_closeInputConnectionIfNeeded()` call in `_updateTextInputState` is a hack for issue #34 — find permanent fix
- The suggestions overlay position flips based on available screen space (top vs bottom)
- `TextInputConnection` must be manually attached/detached on focus changes
- The `_searchId` pattern prevents stale async search results from overwriting newer ones

## When Adding TextInputClient Methods

Flutter periodically adds new methods to `TextInputClient`. When upgrading Flutter SDK:
1. Check if new abstract methods were added to `TextInputClient`
2. Add stub implementations (see existing patterns like `insertTextPlaceholder`, `performSelector`)
3. Test on all Flutter channels (stable, beta, dev)
