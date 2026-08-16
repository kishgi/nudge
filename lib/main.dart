import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/nudge_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/settings/presentation/pages/design_preview_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NudgeApp(),
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
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
        home: const DesignPreviewPage(),
      ),
    );
  }
}
