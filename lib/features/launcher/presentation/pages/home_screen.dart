import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../apps/domain/models/installed_app.dart';
import '../../../settings/presentation/pages/settings_screen.dart';
import '../providers/launcher_state.dart';
import 'app_drawer.dart';
import 'search_overlay.dart';
import '../../../../features/focus/domain/services/app_launcher.dart';

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

  String _formatDate(DateTime date, String pattern) {
    const weekdaysShort = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const weekdaysFull = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const monthsShort = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const monthsFull = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    
    final wdShort = weekdaysShort[date.weekday - 1];
    final wdFull = weekdaysFull[date.weekday - 1];
    final mShort = monthsShort[date.month - 1];
    final mFull = monthsFull[date.month - 1];
    
    if (pattern == 'EEE, MMM d') {
      return '$wdShort, $mShort ${date.day}';
    } else if (pattern == 'EEEE, MMMM d') {
      return '$wdFull, $mFull ${date.day}';
    } else if (pattern == 'dd/MM/yyyy') {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } else if (pattern == 'yyyy-MM-dd') {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
    return '$wdShort, $mShort ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final state = ref.watch(launcherProvider);
    final notifier = ref.read(launcherProvider.notifier);

    // Filter and sort favorites by position, limited to user-defined count
    final rawFavorites = state.allApps.where((app) => app.isFavorite && !app.isHidden).toList();
    rawFavorites.sort((a, b) => a.position.compareTo(b.position));
    final favorites = rawFavorites.take(t.layoutSettings.visibleAppCount).toList();

    // Time formatting
    final String timeString;
    if (t.clockSettings.clockFormat == '12') {
      final hour = _currentTime.hour == 0 ? 12 : (_currentTime.hour > 12 ? _currentTime.hour - 12 : _currentTime.hour);
      final period = _currentTime.hour >= 12 ? 'PM' : 'AM';
      final min = _currentTime.minute.toString().padLeft(2, '0');
      final sec = t.clockSettings.showSeconds ? ':${_currentTime.second.toString().padLeft(2, '0')}' : '';
      timeString = '$hour:$min$sec $period';
    } else {
      final hour = _currentTime.hour.toString().padLeft(2, '0');
      final min = _currentTime.minute.toString().padLeft(2, '0');
      final sec = t.clockSettings.showSeconds ? ':${_currentTime.second.toString().padLeft(2, '0')}' : '';
      timeString = '$hour:$min$sec';
    }

    final dateString = _formatDate(_currentTime, t.clockSettings.dateFormat);

    // Check motion mode
    final transitionDuration = t.motion.normal;

    return Scaffold(
      backgroundColor: t.background,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! < -300) {
            _openAppDrawer(context);
          } else if (details.primaryVelocity! > 300) {
            _openSearchOverlay(context);
          }
        },
        onLongPress: () {
          if (t.clockSettings.clockFontWeight != null && t.clockSettings.showSeconds) {
            HapticFeedback.heavyImpact();
          } else {
            HapticFeedback.mediumImpact();
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: t.layoutSettings.horizontalPadding,
              vertical: NudgeSpacing.pageVertical,
            ),
            child: AnimatedContainer(
              duration: transitionDuration,
              curve: t.motion.curve,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: NudgeSpacing.xl),
                  // Clock section at TOP
                  if (t.layoutSettings.clockPosition == 'top') ...[
                    _buildClockSection(t, timeString, dateString),
                    SizedBox(height: t.layoutSettings.verticalSpacing),
                  ],

                  // Favorites List Section
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
                                final formattedName = t.type.applyCase(app.appName);

                                return Material(
                                  key: ValueKey(app.packageName),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: NudgeRadius.smallAll,
                                    onTap: () async {
                                      final messenger = ScaffoldMessenger.of(context);
                                      final success = await AppLauncher.launch(context, ref, app.packageName);
                                      if (!success) {
                                        messenger.showSnackBar(
                                          SnackBar(
                                            content: Text('Failed to launch $formattedName'),
                                            backgroundColor: t.semanticColors.error,
                                          ),
                                        );
                                      }
                                    },
                                    onLongPress: () {
                                      HapticFeedback.selectionClick();
                                      _showFavoriteActions(context, app, notifier, t);
                                    },
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
                                                      child: Icon(
                                                        Icons.android,
                                                        color: t.secondaryText,
                                                        size: t.iconSettings.size / 2,
                                                      ),
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
                                );
                              },
                            ),
                          ),
                  ),

                  // Clock section at BOTTOM
                  if (t.layoutSettings.clockPosition == 'bottom') ...[
                    SizedBox(height: t.layoutSettings.verticalSpacing),
                    _buildClockSection(t, timeString, dateString),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClockSection(NudgeThemeData t, String timeStr, String dateStr) {
    TextAlign clockTextAlign = TextAlign.left;
    if (t.clockSettings.alignment == Alignment.center) {
      clockTextAlign = TextAlign.center;
    } else if (t.clockSettings.alignment == Alignment.centerRight) {
      clockTextAlign = TextAlign.right;
    }

    return Column(
      crossAxisAlignment: t.clockSettings.alignment == Alignment.center
          ? CrossAxisAlignment.center
          : (t.clockSettings.alignment == Alignment.centerRight
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start),
      children: [
        Text(
          timeStr,
          textAlign: clockTextAlign,
          style: TextStyle(
            fontFamily: t.clockSettings.clockFontFamily ?? t.type.fontFamily,
            fontSize: t.type.display.fontSize! * t.clockSettings.clockSizeScale,
            fontWeight: t.clockSettings.clockFontWeight != null
                ? FontWeight.values.firstWhere((w) => w.value == t.clockSettings.clockFontWeight)
                : t.type.display.fontWeight,
            color: t.primaryText,
            letterSpacing: t.type.display.letterSpacing,
            height: t.type.display.height,
          ),
        ),
        if (t.clockSettings.showDate) ...[
          const SizedBox(height: NudgeSpacing.xs),
          Text(
            dateStr,
            textAlign: clockTextAlign,
            style: t.type.body.copyWith(
              color: t.secondaryText,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
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
                leading: Icon(t.icons.resolve(NudgeIconToken.delete), color: t.primaryText),
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
}
