import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../focus/domain/services/app_launcher.dart';
import '../../../apps/domain/models/installed_app.dart';
import '../../../search/domain/services/search_service.dart';
import '../../../settings/presentation/pages/settings_screen.dart';
import '../../../usage/presentation/providers/usage_provider.dart';
import '../providers/launcher_state.dart';

// Sort mode tab definition
const _sortModes = [
  ('alphabetical', 'A–Z'),
  ('mostUsed', 'Most Used'),
  ('favorites', 'Favorites'),
  ('categories', 'Categories'),
];

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;
  String _query = '';
  late String _sortMode;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(launcherProvider).settings;
    _sortMode = settings.drawerSortMode;
    _scrollController =
        ScrollController(initialScrollOffset: settings.drawerScrollOffset);

    _searchController.addListener(() {
      setState(() => _query = _searchController.text);
    });

    _scrollController.addListener(() {
      // Debounce: save on scroll end (no timer needed; onScrollEnd works fine)
    });
  }

  @override
  void dispose() {
    // Persist scroll position on close
    final offset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    ref.read(launcherProvider.notifier).saveDrawerScrollOffset(offset);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<InstalledApp> _applySort(
    List<InstalledApp> apps,
    Map<String, int> launchCounts,
  ) {
    final sorted = List<InstalledApp>.from(apps);
    switch (_sortMode) {
      case 'mostUsed':
        sorted.sort((a, b) {
          final ca = launchCounts[a.packageName] ?? 0;
          final cb = launchCounts[b.packageName] ?? 0;
          if (cb != ca) return cb.compareTo(ca);
          return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
        });
      case 'favorites':
        sorted.sort((a, b) {
          if (a.isFavorite && !b.isFavorite) return -1;
          if (!a.isFavorite && b.isFavorite) return 1;
          if (a.isFavorite && b.isFavorite) return a.position.compareTo(b.position);
          return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
        });
      case 'categories':
      case 'alphabetical':
      default:
        sorted.sort((a, b) =>
            a.appName.toLowerCase().compareTo(b.appName.toLowerCase()));
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final state = ref.watch(launcherProvider);
    final notifier = ref.read(launcherProvider.notifier);
    final usageState = ref.watch(usageProvider);

    final visibleApps = state.allApps.where((a) => !a.isHidden).toList();

    // Apply search first
    final List<InstalledApp> filteredApps;
    if (_query.isNotEmpty) {
      filteredApps = SearchService.search(visibleApps, _query);
    } else {
      filteredApps = _applySort(visibleApps, usageState.appLaunchCounts);
    }

    return Scaffold(
      backgroundColor: t.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Search bar ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  NudgeSpacing.lg, NudgeSpacing.lg, NudgeSpacing.lg, 0),
              child: TextField(
                controller: _searchController,
                style: t.type.body.copyWith(color: t.primaryText),
                decoration: InputDecoration(
                  hintText: 'Search apps...',
                  prefixIcon: Icon(t.icons.resolve(NudgeIconToken.search),
                      color: t.secondaryText),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: Icon(t.icons.resolve(NudgeIconToken.close),
                              color: t.secondaryText),
                          onPressed: () => _searchController.clear(),
                        )
                      : IconButton(
                          icon: Icon(t.icons.resolve(NudgeIconToken.settings),
                              color: t.secondaryText),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SettingsScreen()),
                            );
                          },
                        ),
                ),
              ),
            ),

            // ── Sort mode tabs (hidden when searching) ──────────────────────
            if (_query.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(NudgeSpacing.lg,
                    NudgeSpacing.sm, NudgeSpacing.lg, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final (key, label) in _sortModes)
                        Padding(
                          padding: const EdgeInsets.only(right: NudgeSpacing.xs),
                          child: _SortChip(
                            label: label,
                            selected: _sortMode == key,
                            theme: t,
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() => _sortMode = key);
                              notifier.updateDrawerSortMode(key);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: NudgeSpacing.sm),

            // ── App list ────────────────────────────────────────────────────
            Expanded(
              child: filteredApps.isEmpty
                  ? Center(
                      child: Text(
                        'No apps found',
                        style: t.type.body.copyWith(color: t.mutedText),
                      ),
                    )
                  : _sortMode == 'categories' && _query.isEmpty
                      ? _CategoriesView(
                          apps: filteredApps,
                          icons: state.appIcons,
                          theme: t,
                          notifier: notifier,
                          scrollController: _scrollController,
                        )
                      : _AppList(
                          apps: filteredApps,
                          icons: state.appIcons,
                          theme: t,
                          notifier: notifier,
                          scrollController: _scrollController,
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sort chip ────────────────────────────────────────────────────────────────

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.selected,
    required this.theme,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final NudgeThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = theme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
            horizontal: NudgeSpacing.md, vertical: NudgeSpacing.xs),
        decoration: BoxDecoration(
          color: selected ? t.accent : t.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? t.accent : t.divider),
        ),
        child: Text(
          label,
          style: t.type.caption.copyWith(
            color: selected ? t.background : t.primaryText,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// ─── Flat app list (alphabetical, most-used, favorites) ────────────────────────

class _AppList extends StatelessWidget {
  const _AppList({
    required this.apps,
    required this.icons,
    required this.theme,
    required this.notifier,
    required this.scrollController,
  });

  final List<InstalledApp> apps;
  final Map<String, dynamic> icons;
  final NudgeThemeData theme;
  final LauncherNotifier notifier;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: NudgeSpacing.pageHorizontal),
      itemCount: apps.length,
      itemBuilder: (context, index) => _AppTile(
        app: apps[index],
        iconBytes: icons[apps[index].packageName],
        theme: theme,
        notifier: notifier,
      ),
    );
  }
}

// ─── Categories grouped view ──────────────────────────────────────────────────

class _CategoriesView extends StatelessWidget {
  const _CategoriesView({
    required this.apps,
    required this.icons,
    required this.theme,
    required this.notifier,
    required this.scrollController,
  });

  final List<InstalledApp> apps;
  final Map<String, dynamic> icons;
  final NudgeThemeData theme;
  final LauncherNotifier notifier;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    // Group apps by category
    final Map<String, List<InstalledApp>> grouped = {};
    for (final app in apps) {
      grouped.putIfAbsent(app.category, () => []).add(app);
    }

    // Sort categories alphabetically; put 'Other' last
    final categories = grouped.keys.toList()
      ..sort((a, b) {
        if (a == 'Other') return 1;
        if (b == 'Other') return -1;
        return a.compareTo(b);
      });

    // Build flat list of header + item entries
    final List<_CategoryEntry> entries = [];
    for (final cat in categories) {
      entries.add(_CategoryEntry.header(cat));
      for (final app in grouped[cat]!) {
        entries.add(_CategoryEntry.app(app));
      }
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: NudgeSpacing.pageHorizontal),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        if (entry.isHeader) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
                NudgeSpacing.sm, NudgeSpacing.md, NudgeSpacing.sm, NudgeSpacing.xs),
            child: Text(
              entry.header!,
              style: theme.type.caption.copyWith(
                color: theme.mutedText,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          );
        }
        return _AppTile(
          app: entry.app!,
          iconBytes: icons[entry.app!.packageName],
          theme: theme,
          notifier: notifier,
        );
      },
    );
  }
}

class _CategoryEntry {
  const _CategoryEntry._({this.header, this.app});
  factory _CategoryEntry.header(String cat) => _CategoryEntry._(header: cat);
  factory _CategoryEntry.app(InstalledApp app) => _CategoryEntry._(app: app);

  final String? header;
  final InstalledApp? app;
  bool get isHeader => header != null;
}

// ─── Single app tile ──────────────────────────────────────────────────────────

class _AppTile extends ConsumerWidget {
  const _AppTile({
    required this.app,
    required this.iconBytes,
    required this.theme,
    required this.notifier,
  });

  final InstalledApp app;
  final dynamic iconBytes;
  final NudgeThemeData theme;
  final LauncherNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = theme;
    final formattedName = t.type.applyCase(app.appName);
    final showIcons = t.layoutSettings.showIcons;

    return Semantics(
      label: 'Launch $formattedName',
      hint: 'Double tap to open app. Long press for options.',
      button: true,
      enabled: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: NudgeRadius.smallAll,
          onTap: () async {
            final navigator = Navigator.of(context);
            final messenger = ScaffoldMessenger.of(context);
            final success = await AppLauncher.launch(context, ref, app.packageName);
            if (success) {
              navigator.pop();
            } else {
              messenger.showSnackBar(SnackBar(
                content: Text('Failed to launch $formattedName'),
                backgroundColor: t.semanticColors.error,
              ));
            }
          },
          onLongPress: () {
            HapticFeedback.selectionClick();
            _showAppActions(context, app, notifier, t);
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
              if (showIcons) ...[
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
              Expanded(
                child: Text(
                  formattedName,
                  style: t.type.body.copyWith(color: t.primaryText),
                  textAlign: t.type.textAlign,
                ),
              ),
              if (app.isFavorite)
                Icon(t.icons.resolve(NudgeIconToken.favorite),
                    color: t.accent, size: 16),
            ],
          ),
        ),
      ),
    ),
  ),
);
}

  void _showAppActions(
    BuildContext context,
    InstalledApp app,
    LauncherNotifier notifier,
    NudgeThemeData t,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: t.surface,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(NudgeRadius.large)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(NudgeSpacing.lg),
              child: Text(app.appName,
                  style: t.type.title.copyWith(color: t.primaryText),
                  textAlign: TextAlign.center),
            ),
            Divider(height: 1, color: t.divider),
            ListTile(
              leading: Icon(
                t.icons.resolve(app.isFavorite ? NudgeIconToken.delete : NudgeIconToken.add),
                color: app.isFavorite ? t.semanticColors.error : t.accent,
              ),
              title: Text(
                app.isFavorite ? 'Remove from Home' : 'Add to Home',
                style: t.type.body.copyWith(
                  color: app.isFavorite ? t.semanticColors.error : t.primaryText,
                ),
              ),
              onTap: () {
                notifier.toggleFavorite(app.packageName);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:
                  Icon(t.icons.resolve(NudgeIconToken.eyeOff), color: t.primaryText),
              title: Text('Hide App',
                  style: t.type.body.copyWith(color: t.primaryText)),
              onTap: () {
                notifier.toggleHidden(app.packageName);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: NudgeSpacing.md),
          ],
        ),
      ),
    );
  }
}
