# Nudge Launcher

Nudge is an intentional, privacy-first, minimal Android home screen launcher built with Flutter and Rust/C++ native bindings via Isar. Designed to reduce screen time and break compulsive phone habits through friction-by-design, configurable delay screens, time-aware smart suggestions, and offline digital wellbeing rules.

---

## Key Features

- **Typography & Minimalism**: Beautiful font options, clean line heights, customizable icon density, and zero home-screen visual clutter.
- **Digital Wellbeing Engine**:
  - **Focus Rules**: App blocking with configurable opening delays (e.g. 5–30 sec breathing pause).
  - **Schedules**: Time-of-day and day-of-week rule activation.
  - **Modes**: Work, Study, Sleep, and Custom focus sessions.
- **Local Smart Suggestions**:
  - Local-only suggestion engine using time-of-day hints, day-of-week usage, launch frequency, and focus session state.
- **Configurable Gestures**:
  - Swipe up, swipe down, double tap, and long press mapped to Drawer, Search, Lock Screen, Settings, or custom actions.
- **Lightweight Home Widgets**:
  - Drag-and-drop orderable widgets: Clock, Date, Real-time Battery level, and Active Focus Session Countdown.
- **Offline & Private**:
  - 100% local database storage (Isar).
  - Zero internet permission (`android.permission.INTERNET` is not included).
  - Local JSON export & import for backups.
- **Accessibility**:
  - High Contrast mode (WCAG AAA compliant contrast).
  - Reduced Motion support.
  - Haptic feedback controls.
  - Minimum 48x48 dp touch target bounds & TalkBack `Semantics` tags.

---

## Project Structure

```
lib/
├── core/
│   ├── database/       # Isar DB service initialization & reset
│   └── theme/          # Nudge design tokens, typography, motion, icons
├── features/
│   ├── apps/           # InstalledApp Isar model
│   ├── backup/         # Local JSON backup export/import & restore service
│   ├── customization/  # ThemeConfig & AppSettings Isar models
│   ├── focus/          # FocusRule, FocusSession & delay overlay screens
│   ├── launcher/       # Home screen, App Drawer, Search Overlay, Gestures, Widgets
│   ├── search/         # Memory-based ranked search service (apps, settings, actions)
│   ├── settings/       # 10-section organized settings UI & pages
│   └── usage/          # Android UsageStats integration & Wellbeing Dashboard
└── main.dart           # App entry point with ProviderScope
```

---

## Building from Source

### Prerequisites
- Flutter SDK `^3.12.2` (Dart `^3.12.2`)
- Android SDK API 34+ (Build-Tools 34.0.0+)
- JDK 17+

### Build Steps

1. **Clone & Install Dependencies**:
   ```bash
   git clone https://github.com/kishgi/nudge.git
   cd nudge
   flutter pub get
   ```

2. **Generate Database Schemas**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Run Unit Tests**:
   ```bash
   flutter test
   ```

4. **Build Production Release APK**:
   ```bash
   flutter build apk --release
   ```
   *Output*: `build/app/outputs/flutter-apk/app-release.apk`

5. **Build Production Release App Bundle (AAB)**:
   ```bash
   flutter build appbundle --release
   ```
   *Output*: `build/app/outputs/bundle/release/app-release.aab`

---

## License & Privacy

- **License**: MIT
- **Privacy Policy**: Nudge does not collect, track, store, or transmit any user data. All processing occurs strictly on device.
