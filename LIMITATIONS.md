# Known Android Platform Limitations

Nudge is designed to operate safely within standard Android OS boundaries. Below are known platform limitations and their technical mitigations.

---

## 1. Double-Tap Lock Screen Gesture
- **Platform Behavior**: Android launchers cannot lock the screen programmatically without `DevicePolicyManager.lockNow()` or `AccessibilityService`.
- **Nudge Implementation**: Nudge calls `DevicePolicyManager.lockNow()`. If Nudge has not been granted Device Admin privileges by the user, the double-tap gesture gracefully no-ops without crashing.
- **Workaround**: Users can grant Device Admin in system settings or assign a different action to double-tap (e.g. Open Search or Open Settings).

---

## 2. Android UsageStats Polling Window
- **Platform Behavior**: Android's `UsageStatsManager` updates foreground time asynchronously. Launch counts on Android 8.0/9.0+ are aggregated in periodic system OS sync intervals.
- **Nudge Implementation**: Nudge queries `queryUsageStats` on dashboard open or search request without continuous background polling loops, preserving 100% battery efficiency.

---

## 3. Custom Icon Pack Vector Thinning
- **Platform Behavior**: Certain third-party icon packs (such as Tabler or Lucide) render using vector stroke paths.
- **Nudge Implementation**: Nudge provides an explicit `iconThickness` and `iconOpacity` slider in Icon Settings to ensure legible rendering on high-DPI displays.

---

## 4. App Category Fallback on Legacy Android Devices
- **Platform Behavior**: `ApplicationInfo.category` was introduced in Android 8.0 (API 26).
- **Nudge Implementation**: On Android 7.1 or older devices (or for apps that do not specify a category in their manifest), Nudge uses package-name prefix heuristics to group apps under standard category headers (`Game`, `Audio`, `Video`, `Social`, `Productivity`, `Other`).
