import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../launcher/domain/gesture_action.dart';
import '../../../launcher/presentation/providers/launcher_state.dart';
import '../../../launcher/presentation/pages/app_drawer.dart';
import '../../../launcher/presentation/pages/search_overlay.dart';
import 'settings_screen.dart';

/// Reads the gesture string from AppSettings and dispatches to the correct action.
void handleGesture(
  BuildContext context,
  WidgetRef ref,
  String gestureKey, {
  VoidCallback? onDrawer,
  VoidCallback? onSearch,
}) {
  final action = GestureAction.fromKey(gestureKey);
  switch (action) {
    case GestureAction.drawer:
      if (onDrawer != null) {
        onDrawer();
      } else {
        _openDrawer(context);
      }
    case GestureAction.search:
      if (onSearch != null) {
        onSearch();
      } else {
        _openSearch(context);
      }
    case GestureAction.lockScreen:
      _lockScreen(ref);
    case GestureAction.settings:
      _openSettings(context);
    case GestureAction.none:
      break;
  }
}

void _openDrawer(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => const AppDrawer(),
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic))
              .animate(animation),
          child: child,
        );
      },
    ),
  );
}

void _openSearch(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => const SearchOverlay(),
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic))
              .animate(animation),
          child: child,
        );
      },
    ),
  );
}

Future<void> _lockScreen(WidgetRef ref) async {
  // Attempt via native platform channel; graceful no-op on failure.
  try {
    await const MethodChannel('com.example.nudge/launcher')
        .invokeMethod<bool>('lockScreen');
  } catch (_) {
    // Device admin not granted — silently ignored.
  }
}

void _openSettings(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const SettingsScreen()),
  );
}

// ─── Gesture settings page ────────────────────────────────────────────────────

/// Settings page to configure what each gesture does on the home screen.
class GestureSettingsPage extends ConsumerWidget {
  const GestureSettingsPage({super.key});

  static const _gestures = [
    _GestureDef(
      label: 'Swipe Up',
      subtitle: 'e.g. open app drawer',
      settingKey: 'swipeUp',
      icon: Icons.swipe_up_outlined,
    ),
    _GestureDef(
      label: 'Swipe Down',
      subtitle: 'e.g. open search',
      settingKey: 'swipeDown',
      icon: Icons.swipe_down_outlined,
    ),
    _GestureDef(
      label: 'Double Tap',
      subtitle: 'e.g. lock screen',
      settingKey: 'doubleTap',
      icon: Icons.touch_app_outlined,
    ),
    _GestureDef(
      label: 'Long Press',
      subtitle: 'e.g. open settings',
      settingKey: 'longPress',
      icon: Icons.pan_tool_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.nudgeTheme;
    final state = ref.watch(launcherProvider);
    final settings = state.settings;
    final notifier = ref.read(launcherProvider.notifier);

    final currentValues = {
      'swipeUp': settings.gestureSwipeUp,
      'swipeDown': settings.gestureSwipeDown,
      'doubleTap': settings.gestureDoubleTap,
      'longPress': settings.gestureLongPress,
    };

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Gesture Settings',
            style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(NudgeSpacing.lg),
        children: [
          Text(
            'Assign an action to each home-screen gesture. Changes take effect immediately.',
            style: t.type.caption.copyWith(color: t.mutedText),
          ),
          const SizedBox(height: NudgeSpacing.xl),
          for (final gesture in _gestures) ...[
            _GestureCard(
              gesture: gesture,
              currentKey: currentValues[gesture.settingKey]!,
              theme: t,
              onChanged: (newKey) =>
                  notifier.updateGesture(gesture.settingKey, newKey),
            ),
            const SizedBox(height: NudgeSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _GestureDef {
  const _GestureDef({
    required this.label,
    required this.subtitle,
    required this.settingKey,
    required this.icon,
  });
  final String label;
  final String subtitle;
  final String settingKey;
  final IconData icon;
}

class _GestureCard extends StatelessWidget {
  const _GestureCard({
    required this.gesture,
    required this.currentKey,
    required this.theme,
    required this.onChanged,
  });

  final _GestureDef gesture;
  final String currentKey;
  final NudgeThemeData theme;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = theme;
    return Container(
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: t.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                NudgeSpacing.md, NudgeSpacing.md, NudgeSpacing.md, NudgeSpacing.sm),
            child: Row(
              children: [
                Icon(gesture.icon, color: t.accent, size: 20),
                const SizedBox(width: NudgeSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(gesture.label,
                        style: t.type.body
                            .copyWith(color: t.primaryText, fontWeight: FontWeight.w600)),
                    Text(gesture.subtitle,
                        style: t.type.caption.copyWith(color: t.mutedText)),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: t.divider),
          for (final action in GestureAction.values)
            RadioListTile<String>(
              dense: true,
              value: action.key,
              groupValue: currentKey,
              activeColor: t.accent,
              title: Text(action.label,
                  style: t.type.body.copyWith(color: t.primaryText)),
              onChanged: (v) {
                if (v != null) {
                  HapticFeedback.selectionClick();
                  onChanged(v);
                }
              },
            ),
        ],
      ),
    );
  }
}
