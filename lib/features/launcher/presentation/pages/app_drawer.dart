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
import '../providers/launcher_state.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final state = ref.watch(launcherProvider);
    final notifier = ref.read(launcherProvider.notifier);

    // Filter out hidden apps
    final visibleApps = state.allApps.where((app) => !app.isHidden).toList();

    // Sort alphabetically by name
    visibleApps.sort((a, b) =>
        a.appName.toLowerCase().compareTo(b.appName.toLowerCase()));

    // Apply search query if present
    final filteredApps = _query.isEmpty
        ? visibleApps
        : SearchService.search(visibleApps, _query);

    final showIcons = t.layoutSettings.showIcons;

    return Scaffold(
      backgroundColor: t.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.all(NudgeSpacing.lg),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                style: t.type.body.copyWith(color: t.primaryText),
                decoration: InputDecoration(
                  hintText: 'Search apps...',
                  prefixIcon: Icon(t.icons.resolve(NudgeIconToken.search), color: t.secondaryText),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: Icon(t.icons.resolve(NudgeIconToken.close), color: t.secondaryText),
                          onPressed: () => _searchController.clear(),
                        )
                      : IconButton(
                          icon: Icon(t.icons.resolve(NudgeIconToken.settings), color: t.secondaryText),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SettingsScreen()),
                            );
                          },
                        ),
                ),
              ),
            ),
            // App list
            Expanded(
              child: filteredApps.isEmpty
                  ? Center(
                      child: Text(
                        'No apps found',
                        style: t.type.body.copyWith(color: t.mutedText),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: NudgeSpacing.pageHorizontal,
                      ),
                      itemCount: filteredApps.length,
                      itemBuilder: (context, index) {
                        final app = filteredApps[index];
                        final iconBytes = state.appIcons[app.packageName];
                        final formattedName = t.type.applyCase(app.appName);

                        return Material(
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
                              _showAppActions(context, app, notifier, t);
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
                                  // Icon if enabled in layout
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
                                              child: Icon(
                                                Icons.android,
                                                color: t.secondaryText,
                                                size: t.iconSettings.size / 2,
                                              ),
                                            ),
                                    ),
                                    const SizedBox(width: NudgeSpacing.md),
                                  ],
                                  // App Name
                                  Expanded(
                                    child: Text(
                                      formattedName,
                                      style: t.type.body.copyWith(
                                        color: t.primaryText,
                                      ),
                                      textAlign: t.type.textAlign,
                                    ),
                                  ),
                                  if (app.isFavorite)
                                    Icon(
                                      t.icons.resolve(NudgeIconToken.favorite),
                                      color: t.accent,
                                      size: 16,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
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
                leading: Icon(
                  t.icons.resolve(NudgeIconToken.favorite),
                  color: t.primaryText,
                ),
                title: Text(
                  app.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                  style: t.type.body.copyWith(color: t.primaryText),
                ),
                onTap: () {
                  notifier.toggleFavorite(app.packageName);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(t.icons.resolve(NudgeIconToken.eyeOff), color: t.primaryText),
                title: Text(
                  'Hide App',
                  style: t.type.body.copyWith(color: t.primaryText),
                ),
                onTap: () {
                  notifier.toggleHidden(app.packageName);
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
