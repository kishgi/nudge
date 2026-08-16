# Android Permissions Documentation

Nudge requests the absolute minimum set of Android permissions required to function as an intentional home screen launcher and digital wellbeing tool.

---

## Permission Breakdown

### 1. Package Query Permission
```xml
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES"/>
```
- **Purpose**: Required on Android 11+ (API 30+) to query and list installed launcher applications on your device.
- **Usage**: Used strictly to build the app drawer and home screen favorites list.
- **Privacy**: Processed entirely on-device; package names are stored in local Isar database.

---

### 2. Usage Access Permission
```xml
<uses-permission android:name="android.permission.PACKAGE_USAGE_STATS" tools:ignore="ProtectedPermissions"/>
```
- **Purpose**: Accesses Android's `UsageStatsManager` system service.
- **Usage**: Required for:
  - Displaying daily & weekly screen time in the Wellbeing Dashboard.
  - Sorting the App Drawer by "Most Used".
  - Driving local time-aware Smart Suggestions.
- **User Grant**: Requires explicit manual user approval in System Settings -> Special App Access -> Usage Access.

---

### 3. Read Contacts Permission (Optional)
```xml
<uses-permission android:name="android.permission.READ_CONTACTS"/>
```
- **Purpose**: Queries local device contact names and phone numbers.
- **Usage**: Enables optional contact search within the Search Overlay (allows direct dialing from search).
- **Privacy**: If permission is not granted, contact search is gracefully skipped without error. No contact data is sent anywhere.

---

## Security Guarantees

- **No Network Permission**: Nudge does not request `android.permission.INTERNET` or `android.permission.ACCESS_NETWORK_STATE`.
- **No Analytics/Telemetry**: Zero third-party SDKs, tracking frameworks, or crash reporters.
- **No Cloud Sync**: All data remains strictly inside the app's private sandbox directory `/data/data/com.example.nudge/`.
