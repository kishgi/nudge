import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../search/domain/models/search_models.dart';
import '../../../search/domain/services/search_service.dart';
import '../../../usage/presentation/providers/usage_provider.dart';
import '../../../focus/domain/services/app_launcher.dart';
import '../../../focus/presentation/providers/focus_provider.dart';
import '../../../settings/presentation/pages/settings_screen.dart';
import '../../../focus/presentation/pages/focus_settings_screen.dart';
import '../../../settings/presentation/pages/gesture_settings_page.dart';
import '../../../settings/presentation/pages/widget_settings_page.dart';
import '../../../settings/presentation/pages/accessibility_settings_page.dart';
import '../../../settings/presentation/pages/home_settings_page.dart';
import '../../../settings/presentation/pages/about_page.dart';
import '../../../backup/presentation/pages/backup_restore_page.dart';
import '../../../usage/presentation/pages/dashboard_screen.dart';
import '../providers/launcher_state.dart';

class SearchOverlay extends ConsumerStatefulWidget {
  const SearchOverlay({super.key});

  @override
  ConsumerState<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends ConsumerState<SearchOverlay> {
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
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleItemTap(BuildContext context, SearchItem item) async {
    final navigator = Navigator.of(context);

    switch (item.type) {
      case SearchItemType.app:
        if (item.app != null) {
          final success = await AppLauncher.launch(context, ref, item.app!.packageName);
          if (success) {
            navigator.pop();
          }
        }
        break;

      case SearchItemType.setting:
        final route = item.settingRoute;
        if (route != null) {
          navigator.pop(); // Close search
          _navigateSetting(context, route);
        }
        break;

      case SearchItemType.action:
        final action = item.actionName;
        if (action != null) {
          navigator.pop(); // Close search
          _triggerAction(context, ref, action);
        }
        break;

      case SearchItemType.contact:
        final number = item.contactNumber;
        if (number != null) {
          navigator.pop(); // Close search
          await ref.read(usageProvider.notifier).dialNumber(number);
        }
        break;
    }
  }

  void _navigateSetting(BuildContext context, String route) {
    Widget? page;
    switch (route) {
      case 'typography':
        page = const TypographySettingsPage();
      case 'icons':
        page = const IconSettingsPage();
      case 'colors':
        page = const ColorSettingsPage();
      case 'layout':
        page = const LayoutSettingsPage();
      case 'clock':
        page = const ClockSettingsPage();
      case 'focus':
        page = const FocusSettingsPage();
      case 'themes':
        page = const ThemesPage();
      case 'wellbeing':
        page = const DashboardScreen();
      case 'gestures':
        page = const GestureSettingsPage();
      case 'widgets':
        page = const WidgetSettingsPage();
      case 'accessibility':
        page = const AccessibilitySettingsPage();
      case 'backup':
        page = const BackupRestorePage();
      case 'about':
        page = const AboutPage();
      case 'home':
        page = const HomeSettingsPage();
    }
    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page!));
    }
  }

  void _triggerAction(BuildContext context, WidgetRef ref, String action) {
    switch (action) {
      case 'focus_work':
        ref.read(focusProvider.notifier).startFocusSession('Work', 25);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Work Focus Session started (25 mins)')),
        );
        break;
      case 'focus_study':
        ref.read(focusProvider.notifier).startFocusSession('Study', 25);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Study Focus Session started (25 mins)')),
        );
        break;
      case 'focus_sleep':
        ref.read(focusProvider.notifier).startFocusSession('Sleep', 480);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sleep Focus Session started (8 hours)')),
        );
        break;
      case 'open_dashboard':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final launcherState = ref.watch(launcherProvider);
    final usageState = ref.watch(usageProvider);

    final visibleApps = launcherState.allApps.where((app) => !app.isHidden).toList();

    // Query combined search results
    final List<SearchItem> results = SearchService.searchAll(
      apps: visibleApps,
      contacts: usageState.contacts,
      appLaunchCounts: usageState.appLaunchCounts,
      query: _query,
    );

    return Scaffold(
      backgroundColor: t.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search Input Field
            Padding(
              padding: const EdgeInsets.all(NudgeSpacing.lg),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                autofocus: true,
                textInputAction: TextInputAction.go,
                style: t.type.body.copyWith(color: t.primaryText),
                decoration: InputDecoration(
                  hintText: 'Search apps, settings, actions...',
                  prefixIcon: Icon(t.icons.resolve(NudgeIconToken.search), color: t.secondaryText),
                  suffixIcon: IconButton(
                    icon: Icon(t.icons.resolve(NudgeIconToken.close), color: t.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                onSubmitted: (value) {
                  if (results.isNotEmpty) {
                    _handleItemTap(context, results.first);
                  }
                },
              ),
            ),
            // Results list
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Text(
                        _query.isEmpty ? 'Type to search' : 'No results found',
                        style: t.type.body.copyWith(color: t.mutedText),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: NudgeSpacing.pageHorizontal,
                      ),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final item = results[index];
                        final isFirst = index == 0;

                        // Resolve trailing "Go" indicator or item type tag
                        Widget? leadingIcon;
                        switch (item.type) {
                          case SearchItemType.app:
                            final iconBytes = launcherState.appIcons[item.app?.packageName];
                            leadingIcon = ClipRRect(
                              borderRadius: NudgeRadius.smallAll,
                              child: iconBytes != null
                                  ? Image.memory(iconBytes, width: 36, height: 36, fit: BoxFit.cover)
                                  : Container(
                                      width: 36,
                                      height: 36,
                                      color: t.divider,
                                      child: Icon(Icons.android, color: t.secondaryText, size: 20),
                                    ),
                            );
                            break;
                          case SearchItemType.setting:
                            leadingIcon = Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: t.accent.withValues(alpha: 0.05),
                                borderRadius: NudgeRadius.smallAll,
                              ),
                              child: Icon(t.icons.resolve(NudgeIconToken.settings), color: t.accent, size: 20),
                            );
                            break;
                          case SearchItemType.action:
                            leadingIcon = Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: t.semanticColors.successSubtle,
                                borderRadius: NudgeRadius.smallAll,
                              ),
                              child: Icon(t.icons.resolve(NudgeIconToken.developer), color: t.semanticColors.success, size: 20),
                            );
                            break;
                          case SearchItemType.contact:
                            leadingIcon = Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: t.secondaryText.withValues(alpha: 0.05),
                                borderRadius: NudgeRadius.smallAll,
                              ),
                              child: Icon(t.icons.resolve(NudgeIconToken.device), color: t.secondaryText, size: 20),
                            );
                            break;
                        }

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: NudgeRadius.smallAll,
                            onTap: () => _handleItemTap(context, item),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: NudgeSpacing.md,
                                horizontal: NudgeSpacing.sm,
                              ),
                              decoration: BoxDecoration(
                                color: isFirst ? t.accent.withValues(alpha: 0.05) : Colors.transparent,
                                borderRadius: NudgeRadius.smallAll,
                                border: isFirst
                                    ? Border.all(color: t.accent.withValues(alpha: 0.2), width: 1)
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  leadingIcon,
                                  const SizedBox(width: NudgeSpacing.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: t.type.body.copyWith(
                                            color: t.primaryText,
                                            fontWeight: isFirst ? FontWeight.w600 : FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          item.subtitle,
                                          style: t.type.caption.copyWith(color: t.mutedText),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isFirst)
                                    Text(
                                      'Go',
                                      style: t.type.caption.copyWith(
                                        color: t.accent,
                                        fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
    );
  }
}
