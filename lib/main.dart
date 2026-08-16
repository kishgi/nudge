import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/database/database_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/nudge_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/launcher/presentation/pages/home_screen.dart';
import 'features/usage/presentation/providers/usage_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final dbService = DatabaseService();
  await dbService.init();

  runApp(
    ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(dbService),
      ],
      child: const NudgeApp(),
    ),
  );
}

class NudgeApp extends ConsumerStatefulWidget {
  const NudgeApp({super.key});

  @override
  ConsumerState<NudgeApp> createState() => _NudgeAppState();
}

class _NudgeAppState extends ConsumerState<NudgeApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Sync initial system brightness
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      ref.read(nudgeThemeProvider.notifier).setSystemBrightness(brightness);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh usage stats on resume — no background polling, zero battery impact.
      ref.read(usageProvider.notifier).refresh();
    }
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    ref.read(nudgeThemeProvider.notifier).setSystemBrightness(brightness);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(nudgeThemeDataProvider);
    final materialTheme = AppTheme.fromNudge(themeData);

    return NudgeTheme(
      data: themeData,
      child: MaterialApp(
        title: 'Nudge',
        debugShowCheckedModeBanner: false,
        theme: materialTheme,
        themeMode: ThemeMode.light, // MaterialApp theming is handled by NudgeTheme
        home: const HomeScreen(),
      ),
    );
  }
}
