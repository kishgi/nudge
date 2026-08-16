import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/pages/focus_block_screen.dart';
import '../../presentation/providers/focus_provider.dart';
import '../../../launcher/presentation/providers/launcher_state.dart';

class AppLauncher {
  AppLauncher._();

  static Future<bool> launch(BuildContext context, WidgetRef ref, String packageName) async {
    final focusNotifier = ref.read(focusProvider.notifier);
    final blockRule = focusNotifier.getActiveBlockRule(packageName, DateTime.now());

    if (blockRule != null) {
      // App is blocked: Navigate to FocusBlockScreen
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FocusBlockScreen(
            packageName: packageName,
            rule: blockRule,
          ),
        ),
      );
      return true;
    } else {
      // Not blocked: Launch intent directly
      return await ref.read(launcherProvider.notifier).launchApp(packageName);
    }
  }
}
