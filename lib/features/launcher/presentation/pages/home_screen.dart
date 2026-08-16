import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/theme_presets.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../apps/domain/models/installed_app.dart';
import '../providers/launcher_state.dart';
import 'app_drawer.dart';
import 'search_overlay.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final state = ref.watch(launcherProvider);
    final notifier = ref.read(launcherProvider.notifier);

    // Filter and sort favorites by position
    final favorites = state.allApps.where((app) => app.isFavorite && !app.isHidden).toList();
    favorites.sort((a, b) => a.position.compareTo(b.position));

    final hour = _currentTime.hour.toString().padLeft(2, '0');
    final minute = _currentTime.minute.toString().padLeft(2, '0');
    final timeString = "$hour:$minute";

    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final weekday = weekdays[_currentTime.weekday - 1];
    final month = months[_currentTime.month - 1];
    final dateString = "$weekday, $month ${_currentTime.day}";

    final mode = state.settings.layoutMode; // TEXT, ICON, HYBRID

    return Scaffold(
      backgroundColor: t.background,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! < -300) {
            // Swipe Up -> App Drawer
            _openAppDrawer(context);
          } else if (details.primaryVelocity! > 300) {
            // Swipe Down -> Search
            _openSearchOverlay(context);
          }
        },
        onLongPress: () => _showCustomizationDialog(context, state, notifier, t),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: NudgeSpacing.pageHorizontal,
              vertical: NudgeSpacing.pageVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: NudgeSpacing.xl),
                // Time & Date Display
                if (state.settings.showTime)
                  Text(
                    timeString,
                    style: t.type.display.copyWith(
                      color: t.primaryText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                if (state.settings.showDate) ...[
                  const SizedBox(height: NudgeSpacing.xs),
                  Text(
                    dateString,
                    style: t.type.body.copyWith(
                      color: t.secondaryText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
                const SizedBox(height: NudgeSpacing.huge),

                // Favorites Header
                Text(
                  'FAVORITES',
                  style: t.type.caption.copyWith(
                    color: t.mutedText,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: NudgeSpacing.md),

                // Favorites List
                Expanded(
                  child: favorites.isEmpty
                      ? Center(
                          child: Text(
                            'Swipe up for drawer to add favorites\nLong-press background for settings',
                            style: t.type.body.copyWith(color: t.mutedText),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Theme(
                          // Override canvas color to transparent for dragging shadow
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.transparent,
                          ),
                          child: ReorderableListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: favorites.length,
                            // ignore: deprecated_member_use
                            onReorder: notifier.reorderFavorites,
                            itemBuilder: (context, index) {
                              final app = favorites[index];
                              final iconBytes = state.appIcons[app.packageName];

                              return Material(
                                key: ValueKey(app.packageName),
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: NudgeRadius.smallAll,
                                  onTap: () async {
                                    final messenger = ScaffoldMessenger.of(context);
                                    final success = await notifier.launchApp(app.packageName);
                                    if (!success) {
                                      messenger.showSnackBar(
                                        SnackBar(
                                          content: Text('Failed to launch ${app.appName}'),
                                          backgroundColor: t.semanticColors.error,
                                        ),
                                      );
                                    }
                                  },
                                  onLongPress: () =>
                                      _showFavoriteActions(context, app, notifier, t),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: NudgeSpacing.md,
                                      horizontal: NudgeSpacing.sm,
                                    ),
                                    child: Row(
                                      children: [
                                        // Grab handle or status indicator
                                        Icon(
                                          Icons.drag_indicator,
                                          color: t.mutedText.withValues(alpha: 0.5),
                                          size: 18,
                                        ),
                                        const SizedBox(width: NudgeSpacing.md),

                                        // Icon if HYBRID or ICON mode
                                        if (mode == 'ICON' || mode == 'HYBRID') ...[
                                          ClipRRect(
                                            borderRadius: NudgeRadius.smallAll,
                                            child: iconBytes != null
                                                ? Image.memory(
                                                    iconBytes,
                                                    width: 32,
                                                    height: 32,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(
                                                    width: 32,
                                                    height: 32,
                                                    color: t.divider,
                                                    child: Icon(
                                                      Icons.android,
                                                      color: t.secondaryText,
                                                      size: 16,
                                                    ),
                                                  ),
                                          ),
                                          const SizedBox(width: NudgeSpacing.md),
                                        ],

                                        // App Name
                                        if (mode == 'TEXT' || mode == 'HYBRID')
                                          Expanded(
                                            child: Text(
                                              app.appName,
                                              style: t.type.body.copyWith(
                                                color: t.primaryText,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        if (mode == 'ICON')
                                          Expanded(
                                            child: Text(
                                              app.appName,
                                              style: t.type.body.copyWith(
                                                color: t.primaryText,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openAppDrawer(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const AppDrawer(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _openSearchOverlay(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SearchOverlay(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, -1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _showFavoriteActions(
    BuildContext context,
    InstalledApp app,
    LauncherNotifier notifier,
    NudgeThemeData t,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: t.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(NudgeRadius.large),
        ),
      ),
      builder: (context) {
        return SafeArea(
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
                leading: Icon(Icons.star_border, color: t.primaryText),
                title: Text(
                  'Remove from Favorites',
                  style: t.type.body.copyWith(color: t.primaryText),
                ),
                onTap: () {
                  notifier.toggleFavorite(app.packageName);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: NudgeSpacing.md),
            ],
          ),
        );
      },
    );
  }

  void _showCustomizationDialog(
    BuildContext context,
    LauncherState state,
    LauncherNotifier notifier,
    NudgeThemeData t,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: t.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(NudgeRadius.medium),
            side: BorderSide(color: t.divider, width: 1),
          ),
          title: Text(
            'Launcher Configuration',
            style: t.type.title.copyWith(color: t.primaryText),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LAYOUT MODE',
                style: t.type.caption.copyWith(color: t.mutedText),
              ),
              const SizedBox(height: NudgeSpacing.xs),
              Wrap(
                spacing: NudgeSpacing.sm,
                children: ['TEXT', 'ICON', 'HYBRID'].map((mode) {
                  final isSelected = state.settings.layoutMode == mode;
                  return ChoiceChip(
                    label: Text(mode),
                    selected: isSelected,
                    selectedColor: t.accent,
                    backgroundColor: t.background,
                    labelStyle: t.type.label.copyWith(
                      color: isSelected ? Colors.white : t.primaryText,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        notifier.updateLayoutMode(mode);
                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: NudgeSpacing.lg),
              Text(
                'THEME PRESET',
                style: t.type.caption.copyWith(color: t.mutedText),
              ),
              const SizedBox(height: NudgeSpacing.xs),
              Wrap(
                spacing: NudgeSpacing.xs,
                runSpacing: NudgeSpacing.xs,
                children: NudgeThemePreset.values.map((preset) {
                  final isSelected = state.settings.themePresetName == preset.name;
                  return ChoiceChip(
                    label: Text(preset.label),
                    selected: isSelected,
                    selectedColor: t.accent,
                    backgroundColor: t.background,
                    labelStyle: t.type.label.copyWith(
                      color: isSelected ? Colors.white : t.primaryText,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        notifier.updateThemePreset(preset.name);
                        ref.read(nudgeThemeProvider.notifier).setPreset(preset);
                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: t.type.label.copyWith(color: t.accent),
              ),
            ),
          ],
        );
      },
    );
  }
}
