# 🐧 Distro Finder — Flutter Quiz App (v2)

A terminal-aesthetic Flutter quiz app that recommends a Linux distro based on your preferences.

## Project Structure

```
lib/
├── main.dart                    ← App root + ScreenUtil + theme wiring
│
├── logic/
│   ├── models.dart              ← QuizQuestion, HistoryEntry
│   ├── quiz_data.dart           ← Questions, distro names/emojis/colors/descriptions, score matrix
│   └── quiz_engine.dart         ← recommend() scorer + lightTheme() / darkTheme() builders
│
├── screens/
│   ├── quiz_shell.dart          ← Scaffold + AppBar + AnimatedSwitcher + all state
│   ├── welcome_screen.dart      ← Landing / intro screen
│   ├── question_screen.dart     ← Single question view
│   └── result_screen.dart       ← Recommendation result view
│
└── widgets/
    ├── shared_widgets.dart      ← ChoiceCard, TerminalLine, ProgressDots
    └── history_drawer.dart      ← Drawer + HistoryTile
```

## Features

- **5-question quiz** — terminal comfort, use case, tweaking, release model, desktop vibe
- **8 distros** — Ubuntu, Fedora, Arch, Debian, Pop!\_OS, Manjaro, Linux Mint, NixOS
- **Light / Dark mode** toggle in AppBar
- **History drawer** with relative timestamps
- **Responsive** via `flutter_screenutil` (design baseline 360×800)
- **No router, no state-management package** — plain `StatefulWidget` + `setState`
- **No deprecated APIs** — uses `Color.withValues(alpha:)` instead of `withOpacity`

## Setup

```bash
flutter pub get
flutter run
```

## Customisation

| File | What to change |
|---|---|
| `logic/quiz_data.dart` | Add/edit questions, distros, score weights |
| `logic/quiz_engine.dart` | Tweak theme colours |
| `widgets/shared_widgets.dart` | Reskin ChoiceCard / ProgressDots |
