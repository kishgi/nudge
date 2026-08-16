# Nudge Architecture Documentation

## Architectural Overview

Nudge follows a **Feature-First Clean Architecture** with **Riverpod State Management** and an **Isar Local Database**.

```
                       +------------------------+
                       |    UI Layer (Pages)    |
                       +-----------+------------+
                                   |
                                   v
                       +------------------------+
                       |  Riverpod Notifiers    |
                       +-----------+------------+
                                   |
                                   v
                       +------------------------+
                       |   Domain Services      |
                       +-----------+------------+
                                   |
                                   v
                       +------------------------+
                       | Isar Database / Native |
                       +------------------------+
```

---

## Core Layers & Principles

### 1. Data Layer & Local Persistence (`Isar Database`)
- **Engine**: `isar_community` (pure C++ engine compiled for Android ARM/x86 architectures).
- **Collections**:
  - `AppSettings`: Stores gestures, drawer preferences, home widgets layout, smart suggestions toggles.
  - `ThemeConfig`: Stores active and custom theme tokens (typography, color presets, density, icons, accessibility flags).
  - `InstalledApp`: Holds package names, custom names, favorite state, hidden status, position, and category.
  - `FocusRule`: Stores block status, delay seconds, schedule days/hours, custom friction messages.
  - `FocusSession`: Tracks active focus sessions (Work, Study, Sleep, Custom).
  - `AppUsageSummary`: Persists daily app screen time and launch counts.

### 2. State Management (`Riverpod`)
- **Pattern**: `NotifierProvider` for mutable launcher states and `Provider` for pure computational selectors.
- **Key Providers**:
  - `launcherProvider`: Manages `InstalledApp` lists, in-memory icon bytes cache, and `AppSettings`.
  - `nudgeThemeProvider`: Manages active `ThemeConfig` and generates immutable `NudgeThemeData` objects.
  - `focusProvider`: Evaluates focus rules and active sessions when app launch attempts occur.
  - `usageProvider`: Manages native Android `UsageStatsManager` bridging and contact list queries.

### 3. Native Android Bridge (`MethodChannel` & `EventChannel`)
- `com.example.nudge/launcher`:
  - `getInstalledApps`: Retrieves installed launcher packages, names, icons, and `ApplicationInfo.category`.
  - `launchApp`: Invokes `startActivity` for specified package name.
  - `lockScreen`: Invokes `DevicePolicyManager.lockNow()`.
  - `getAppUsageStats`: Queries Android `UsageStatsManager`.
- `com.example.nudge/battery`:
  - Broadcast `EventChannel` streaming real-time battery percentage updates.

---

## Performance & Memory Strategy

1. **Memory Icon Caching**:
   - Icons are decoded once into a `Map<String, Uint8List>` memory cache on startup/app change.
   - Prevents file I/O or native IPC on every scroll frame.

2. **Memory-Based Ranked Search**:
   - `SearchService` operates on the cached memory list of `InstalledApp` items.
   - Computes base scores: `Exact (1M) > Prefix (800k) > Word Prefix (600k) > Substring (400k) > Fuzzy (200k) + Usage Boost`.
   - Execution time is `< 10ms` for up to 500 installed apps.

3. **Non-Blocking Warm Render**:
   - Initial read uses synchronous Isar queries (`findFirstSync()`) to populate UI instantly on startup (<300ms).
   - Dynamic package updates are processed asynchronously in microtasks.

---

## Security & Privacy Architecture

- **Zero Network Permitted**: `android.permission.INTERNET` is omitted from `AndroidManifest.xml`.
- **Local-Only Processing**: All analytics, smart suggestions, search, and focus enforcement are executed locally.
- **Backup Verification**: Backup payloads use explicit schema versioning and input sanitization before transactional write.
