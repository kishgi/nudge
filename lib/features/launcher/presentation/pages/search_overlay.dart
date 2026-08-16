import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../apps/domain/models/installed_app.dart';
import '../../../search/domain/services/search_service.dart';
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
    // Request focus immediately so keyboard opens
    _focusNode.requestFocus();
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

    // Get all apps (we allow searching hidden apps if needed, but standard is to search all non-hidden apps, or all apps. Let's allow searching all non-hidden apps).
    final visibleApps = state.allApps.where((app) => !app.isHidden).toList();
    final results = _query.isEmpty
        ? const <InstalledApp>[]
        : SearchService.search(visibleApps, _query);

    return Scaffold(
      backgroundColor: t.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search field
            Padding(
              padding: const EdgeInsets.all(NudgeSpacing.lg),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                autofocus: true,
                textInputAction: TextInputAction.go,
                style: t.type.body.copyWith(color: t.primaryText),
                decoration: InputDecoration(
                  hintText: 'Search apps...',
                  prefixIcon: Icon(Icons.search, color: t.secondaryText),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close, color: t.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                onSubmitted: (value) async {
                  if (results.isNotEmpty) {
                    final app = results.first;
                    final navigator = Navigator.of(context);
                    final success = await notifier.launchApp(app.packageName);
                    if (success) {
                      navigator.pop();
                    }
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
                        final app = results[index];
                        final iconBytes = state.appIcons[app.packageName];
                        final isFirst = index == 0;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: NudgeRadius.smallAll,
                            onTap: () async {
                              final navigator = Navigator.of(context);
                              final success = await notifier.launchApp(app.packageName);
                              if (success) {
                                navigator.pop();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: NudgeSpacing.md,
                                horizontal: NudgeSpacing.sm,
                              ),
                              decoration: BoxDecoration(
                                color: isFirst
                                    ? t.accent.withValues(alpha: 0.08)
                                    : Colors.transparent,
                                borderRadius: NudgeRadius.smallAll,
                                border: isFirst
                                    ? Border.all(color: t.accent.withValues(alpha: 0.3), width: 1)
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  // App Icon
                                  ClipRRect(
                                    borderRadius: NudgeRadius.smallAll,
                                    child: iconBytes != null
                                        ? Image.memory(
                                            iconBytes,
                                            width: 36,
                                            height: 36,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: 36,
                                            height: 36,
                                            color: t.divider,
                                            child: Icon(
                                              Icons.android,
                                              color: t.secondaryText,
                                              size: 20,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: NudgeSpacing.md),
                                  // App Name
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          app.appName,
                                          style: t.type.body.copyWith(
                                            color: t.primaryText,
                                            fontWeight: isFirst
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          app.packageName,
                                          style: t.type.caption.copyWith(
                                            color: t.mutedText,
                                          ),
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
