import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/theme_provider.dart';

class HomeSettingsPage extends ConsumerWidget {
  const HomeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.nudgeTheme;
    final themeState = ref.watch(nudgeThemeProvider);
    final config = themeState.config;
    final themeNotifier = ref.read(nudgeThemeProvider.notifier);

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Home Settings', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(NudgeSpacing.lg),
        children: [
          // Show App Icons
          SwitchListTile(
            title: Text('Show App Icons', style: t.type.body.copyWith(color: t.primaryText)),
            subtitle: Text('Display icons alongside app text labels', style: t.type.caption.copyWith(color: t.mutedText)),
            value: config.showIcons,
            activeColor: t.accent,
            onChanged: (val) {
              HapticFeedback.selectionClick();
              themeNotifier.applyConfig(config..showIcons = val);
            },
          ),
          Divider(color: t.divider),

          // Visible App Count
          Padding(
            padding: const EdgeInsets.symmetric(vertical: NudgeSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Visible Favorites Count', style: t.type.body.copyWith(color: t.primaryText)),
                    const Spacer(),
                    Text('${config.visibleAppCount}', style: t.type.caption.copyWith(color: t.accent, fontWeight: FontWeight.bold)),
                  ],
                ),
                Slider(
                  value: config.visibleAppCount.toDouble(),
                  min: 3,
                  max: 12,
                  divisions: 9,
                  activeColor: t.accent,
                  onChanged: (val) {
                    themeNotifier.applyConfig(config..visibleAppCount = val.toInt());
                  },
                ),
              ],
            ),
          ),
          Divider(color: t.divider),

          // Horizontal Padding
          Padding(
            padding: const EdgeInsets.symmetric(vertical: NudgeSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Horizontal Padding', style: t.type.body.copyWith(color: t.primaryText)),
                    const Spacer(),
                    Text('${config.horizontalPadding.round()} px', style: t.type.caption.copyWith(color: t.accent, fontWeight: FontWeight.bold)),
                  ],
                ),
                Slider(
                  value: config.horizontalPadding,
                  min: 12,
                  max: 48,
                  divisions: 12,
                  activeColor: t.accent,
                  onChanged: (val) {
                    themeNotifier.applyConfig(config..horizontalPadding = val);
                  },
                ),
              ],
            ),
          ),
          Divider(color: t.divider),

          // App Density
          Padding(
            padding: const EdgeInsets.symmetric(vertical: NudgeSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App List Density', style: t.type.body.copyWith(color: t.primaryText)),
                const SizedBox(height: NudgeSpacing.xs),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'compact', label: Text('Compact')),
                    ButtonSegment(value: 'normal', label: Text('Normal')),
                    ButtonSegment(value: 'comfortable', label: Text('Comfortable')),
                  ],
                  selected: {config.appDensity},
                  onSelectionChanged: (set) {
                    HapticFeedback.selectionClick();
                    themeNotifier.applyConfig(config..appDensity = set.first);
                  },
                ),
              ],
            ),
          ),
          Divider(color: t.divider),

          // App Alignment
          Padding(
            padding: const EdgeInsets.symmetric(vertical: NudgeSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App List Alignment', style: t.type.body.copyWith(color: t.primaryText)),
                const SizedBox(height: NudgeSpacing.xs),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'left', label: Text('Left')),
                    ButtonSegment(value: 'center', label: Text('Center')),
                    ButtonSegment(value: 'right', label: Text('Right')),
                  ],
                  selected: {config.appAlignment},
                  onSelectionChanged: (set) {
                    HapticFeedback.selectionClick();
                    themeNotifier.applyConfig(config..appAlignment = set.first);
                  },
                ),
              ],
            ),
          ),
          Divider(color: t.divider),

          // Clock Position
          Padding(
            padding: const EdgeInsets.symmetric(vertical: NudgeSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Clock Position', style: t.type.body.copyWith(color: t.primaryText)),
                const SizedBox(height: NudgeSpacing.xs),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'top', label: Text('Top')),
                    ButtonSegment(value: 'bottom', label: Text('Bottom')),
                    ButtonSegment(value: 'hidden', label: Text('Hidden')),
                  ],
                  selected: {config.clockPosition},
                  onSelectionChanged: (set) {
                    HapticFeedback.selectionClick();
                    themeNotifier.applyConfig(config..clockPosition = set.first);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
