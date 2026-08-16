import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../apps/domain/models/installed_app.dart';
import '../../../settings/presentation/pages/settings_screen.dart';
import '../../../usage/presentation/providers/usage_provider.dart';
import '../../../focus/presentation/providers/focus_provider.dart';
import '../../../focus/domain/services/app_launcher.dart';
import '../../../focus/presentation/pages/focus_settings_screen.dart';
import '../../domain/services/suggestion_service.dart';
import '../../domain/models/home_widget_config.dart';
import '../providers/launcher_state.dart';
import '../widgets/home_widgets.dart';
import 'app_drawer.dart';
import 'search_overlay.dart';
import 'add_apps_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // ── Gesture dispatch ────────────────────────────────────────────────────────

  void _dispatch(String gestureKey) {
    switch (gestureKey) {
      case 'drawer':
        _openDrawer();
      case 'search':
        _openSearch();
      case 'lockScreen':
        _lockScreen();
      case 'settings':
        _openSettings();
      case 'none':
        break;
    }
  }

  void _openDrawer() => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AppDrawer(),
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic))
                .animate(anim),
            child: child,
          ),
        ),
      );

  void _openSearch() => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SearchOverlay(),
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic))
                .animate(anim),
            child: child,
          ),
        ),
      );

  void _openAddApps() => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddAppsScreen()),
      );

  Future<void> _lockScreen() async {
    try {
      await const MethodChannel('com.example.nudge/launcher')
          .invokeMethod<bool>('lockScreen');
    } catch (_) {
      // DevicePolicyManager not granted — silently ignored.
    }
  }

  void _openSettings() => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
      );

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final state = ref.watch(launcherProvider);
    final notifier = ref.read(launcherProvider.notifier);
    final usageState = ref.watch(usageProvider);
    final focusState = ref.watch(focusProvider);
    final settings = state.settings;

    // Gesture bindings from settings
    final swipeUp = settings.gestureSwipeUp;
    final swipeDown = settings.gestureSwipeDown;
    final doubleTap = settings.gestureDoubleTap;
    final longPress = settings.gestureLongPress;

    // Home Apps selected explicitly by user (isFavorite == true)
    final selectedHomeApps = state.allApps
        .where((a) => a.isFavorite && !a.isHidden)
        .toList()
      ..sort((a, b) => a.position.compareTo(b.position));

    // Smart suggestions
    final suggestions = settings.showSmartSuggestions
        ? SuggestionService.suggest(
            apps: state.allApps.where((a) => !a.isHidden).toList(),
            appLaunchCounts: usageState.appLaunchCounts,
            blockedPackages: focusState.rules
                .where((r) => r.isActiveAt(DateTime.now()))
                .map((r) => r.packageName)
                .toSet(),
          )
        : <InstalledApp>[];

    // Widget strip config
    final widgetConfigs = HomeWidgetConfigList.decode(settings.homeWidgetsJson);

    return Scaffold(
      backgroundColor: t.background,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! < -300) {
            HapticFeedback.lightImpact();
            _dispatch(swipeUp);
          } else if (details.primaryVelocity! > 300) {
            HapticFeedback.lightImpact();
            _dispatch(swipeDown);
          }
        },
        onDoubleTap: () {
          HapticFeedback.mediumImpact();
          _dispatch(doubleTap);
        },
        onLongPress: () {
          HapticFeedback.heavyImpact();
          _dispatch(longPress);
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: t.layoutSettings.horizontalPadding,
              vertical: NudgeSpacing.pageVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: NudgeSpacing.xl),

                // ── Top Widget Strip ──────────────────────────────────────
                if (t.layoutSettings.clockPosition == 'top') ...[
                  HomeWidgetStrip(
                    widgets: widgetConfigs,
                    spacing: settings.widgetSpacing,
                    alignment: settings.widgetAlignment,
                  ),
                  SizedBox(height: t.layoutSettings.verticalSpacing),
                ],

                // ── Smart Suggestions Strip ───────────────────────────────
                if (suggestions.isNotEmpty && selectedHomeApps.isNotEmpty) ...[
                  _SuggestionsStrip(
                    suggestions: suggestions,
                    icons: state.appIcons,
                    theme: t,
                  ),
                  const SizedBox(height: NudgeSpacing.sm),
                ],

                // ── Home App List or Empty State ──────────────────────────
                Expanded(
                  child: selectedHomeApps.isEmpty
                      ? _buildEmptyHomeState(context, t)
                      : Column(
                          children: [
                            Expanded(
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    canvasColor: Colors.transparent),
                                child: ReorderableListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: selectedHomeApps.length,
                                  // ignore: deprecated_member_use
                                  onReorder: notifier.reorderFavorites,
                                  itemBuilder: (context, index) {
                                    final app = selectedHomeApps[index];
                                    final iconBytes = state.appIcons[app.packageName];
                                    final formattedName = t.type.applyCase(app.appName);
                                    return _HomeAppTile(
                                      key: ValueKey(app.packageName),
                                      app: app,
                                      formattedName: formattedName,
                                      iconBytes: iconBytes,
                                      theme: t,
                                      notifier: notifier,
                                    );
                                  },
                                ),
                              ),
                            ),

                            // "+ Add Apps" Button at bottom of selected app list
                            Padding(
                              padding: const EdgeInsets.only(top: NudgeSpacing.md),
                              child: Center(
                                child: TextButton.icon(
                                  icon: Icon(Icons.add, color: t.accent, size: 20),
                                  label: Text(
                                    'Add Apps',
                                    style: t.type.body.copyWith(
                                      color: t.accent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: _openAddApps,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),

                // ── Bottom Widget Strip ───────────────────────────────────
                if (t.layoutSettings.clockPosition == 'bottom') ...[
                  SizedBox(height: t.layoutSettings.verticalSpacing),
                  HomeWidgetStrip(
                    widgets: widgetConfigs,
                    spacing: settings.widgetSpacing,
                    alignment: settings.widgetAlignment,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Empty Home State ────────────────────────────────────────────────────────

  Widget _buildEmptyHomeState(BuildContext context, NudgeThemeData t) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: NudgeSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nudge',
              style: t.type.display.copyWith(
                color: t.primaryText,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: NudgeSpacing.md),
            Text(
              'Keep only what matters.',
              style: t.type.title.copyWith(color: t.accent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: NudgeSpacing.xs),
            Text(
              'Choose the apps you actually want on your home screen.',
              style: t.type.body.copyWith(color: t.mutedText),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: NudgeSpacing.xl),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Apps'),
              style: ElevatedButton.styleFrom(
                backgroundColor: t.accent,
                foregroundColor: t.background,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                textStyle: t.type.body.copyWith(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _openAddApps,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Smart Suggestions Strip ──────────────────────────────────────────────────

class _SuggestionsStrip extends StatelessWidget {
  const _SuggestionsStrip({
    required this.suggestions,
    required this.icons,
    required this.theme,
  });

  final List<InstalledApp> suggestions;
  final Map<String, dynamic> icons;
  final NudgeThemeData theme;

  @override
  Widget build(BuildContext context) {
    final t = theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggested',
          style: t.type.caption
              .copyWith(color: t.mutedText, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: NudgeSpacing.xs),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: suggestions.map((app) {
              final iconBytes = icons[app.packageName];
              return Padding(
                padding: const EdgeInsets.only(right: NudgeSpacing.sm),
                child: _SuggestionChip(
                  app: app,
                  iconBytes: iconBytes,
                  theme: t,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SuggestionChip extends ConsumerWidget {
  const _SuggestionChip({
    required this.app,
    required this.iconBytes,
    required this.theme,
  });

  final InstalledApp app;
  final dynamic iconBytes;
  final NudgeThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = theme;
    final name = t.type.applyCase(app.appName);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          HapticFeedback.selectionClick();
          await AppLauncher.launch(context, ref, app.packageName);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: NudgeSpacing.sm, vertical: NudgeSpacing.xs),
          decoration: BoxDecoration(
            color: t.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: t.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconBytes != null) ...[
                ClipRRect(
                  borderRadius: NudgeRadius.smallAll,
                  child: Image.memory(iconBytes,
                      width: 20, height: 20, fit: BoxFit.cover),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                name.length > 10 ? '${name.substring(0, 10)}…' : name,
                style: t.type.caption.copyWith(color: t.primaryText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Selected Home App Tile ───────────────────────────────────────────────────

class _HomeAppTile extends ConsumerWidget {
  const _HomeAppTile({
    super.key,
    required this.app,
    required this.formattedName,
    required this.iconBytes,
    required this.theme,
    required this.notifier,
  });

  final InstalledApp app;
  final String formattedName;
  final dynamic iconBytes;
  final NudgeThemeData theme;
  final LauncherNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = theme;

    return Semantics(
      label: 'Launch $formattedName',
      hint: 'Double tap to open app. Long press to remove from Home Screen.',
      button: true,
      enabled: true,
      child: Material(
        key: ValueKey(app.packageName),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: NudgeRadius.smallAll,
          onTap: () async {
            final messenger = ScaffoldMessenger.of(context);
            final success = await AppLauncher.launch(context, ref, app.packageName);
            if (!success) {
              messenger.showSnackBar(SnackBar(
                content: Text('Failed to launch $formattedName'),
                backgroundColor: t.semanticColors.error,
              ));
            }
          },
          onLongPress: () {
            HapticFeedback.selectionClick();
            _showActions(context, t);
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: t.layoutSettings.density.verticalPadding,
                horizontal: NudgeSpacing.sm,
              ),
              child: Row(
                mainAxisAlignment: t.layoutSettings.alignment == Alignment.center
                    ? MainAxisAlignment.center
                    : (t.layoutSettings.alignment == Alignment.centerRight
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start),
                children: [
                  if (t.layoutSettings.showIcons) ...[
                    ClipRRect(
                      borderRadius: NudgeRadius.smallAll,
                      child: iconBytes != null
                          ? Opacity(
                              opacity: t.iconSettings.opacity,
                              child: Image.memory(
                                iconBytes,
                                width: t.iconSettings.size,
                                height: t.iconSettings.size,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: t.iconSettings.size,
                              height: t.iconSettings.size,
                              color: t.divider,
                              child: Icon(Icons.android,
                                  color: t.secondaryText,
                                  size: t.iconSettings.size / 2),
                            ),
                    ),
                    const SizedBox(width: NudgeSpacing.md),
                  ],
                  Text(
                    formattedName,
                    style: t.type.body.copyWith(color: t.primaryText),
                    textAlign: t.type.textAlign,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showActions(BuildContext context, NudgeThemeData t) {
    showModalBottomSheet(
      context: context,
      backgroundColor: t.surface,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(NudgeRadius.large)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(NudgeSpacing.lg),
              child: Text(
                app.appName,
                style: t.type.title.copyWith(color: t.primaryText),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(height: 1, color: t.divider),
            ListTile(
              leading: Icon(t.icons.resolve(NudgeIconToken.delete),
                  color: t.semanticColors.error),
              title: Text('Remove from Home',
                  style: t.type.body.copyWith(color: t.semanticColors.error)),
              subtitle: Text('Keeps app installed on phone',
                  style: t.type.caption.copyWith(color: t.mutedText)),
              onTap: () {
                notifier.removeHomeApp(app.packageName);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: Icon(t.icons.resolve(NudgeIconToken.focus),
                  color: t.primaryText),
              title: Text('Set Delay & Block Rules',
                  style: t.type.body.copyWith(color: t.primaryText)),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FocusSettingsPage()),
                );
              },
            ),
            const SizedBox(height: NudgeSpacing.md),
          ],
        ),
      ),
    );
  }
}
