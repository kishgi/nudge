import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../apps/domain/models/installed_app.dart';
import '../../../search/domain/services/search_service.dart';
import '../providers/launcher_state.dart';

/// Selection screen allowing users to pick which installed apps appear on their Home Screen.
class AddAppsScreen extends ConsumerStatefulWidget {
  const AddAppsScreen({super.key});

  @override
  ConsumerState<AddAppsScreen> createState() => _AddAppsScreenState();
}

class _AddAppsScreenState extends ConsumerState<AddAppsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final state = ref.watch(launcherProvider);
    final notifier = ref.read(launcherProvider.notifier);

    // Get all non-hidden installed apps on the device
    final availableApps = state.allApps.where((a) => !a.isHidden).toList()
      ..sort((a, b) => a.appName.toLowerCase().compareTo(b.appName.toLowerCase()));

    // Filter by query if present
    final filteredApps = _query.isEmpty
        ? availableApps
        : SearchService.search(availableApps, _query);

    final selectedCount = availableApps.where((a) => a.isFavorite).length;

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Apps',
          style: t.type.headline.copyWith(color: t.primaryText),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle & Search Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: NudgeSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$selectedCount apps selected for Home Screen',
                    style: t.type.caption.copyWith(color: t.accent, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: NudgeSpacing.sm),
                  TextField(
                    controller: _searchController,
                    style: t.type.body.copyWith(color: t.primaryText),
                    decoration: InputDecoration(
                      hintText: 'Search apps...',
                      prefixIcon: Icon(t.icons.resolve(NudgeIconToken.search), color: t.secondaryText),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: Icon(t.icons.resolve(NudgeIconToken.close), color: t.secondaryText),
                              onPressed: () => _searchController.clear(),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: NudgeSpacing.md),

            // App List with Selection Checkmarks
            Expanded(
              child: filteredApps.isEmpty
                  ? Center(
                      child: Text(
                        'No matching apps found',
                        style: t.type.body.copyWith(color: t.mutedText),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: NudgeSpacing.pageHorizontal),
                      itemCount: filteredApps.length,
                      itemBuilder: (context, index) {
                        final app = filteredApps[index];
                        final isSelected = app.isFavorite;
                        final formattedName = t.type.applyCase(app.appName);

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: NudgeRadius.smallAll,
                            onTap: () {
                              HapticFeedback.selectionClick();
                              notifier.setHomeAppSelected(app.packageName, !isSelected);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: NudgeSpacing.md,
                                horizontal: NudgeSpacing.sm,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      formattedName,
                                      style: t.type.body.copyWith(
                                        color: isSelected ? t.primaryText : t.secondaryText,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: isSelected ? t.accent : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected ? t.accent : t.divider,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Icon(
                                            Icons.check,
                                            size: 18,
                                            color: t.background,
                                          )
                                        : null,
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
