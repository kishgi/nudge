import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../launcher/domain/models/home_widget_config.dart';
import '../../../launcher/presentation/providers/launcher_state.dart';

import '../../../../core/theme/nudge_icons.dart';

/// Drag-and-drop reorderable settings page for home widgets.
/// Controls visibility and display order of the widget strip.
class WidgetSettingsPage extends ConsumerStatefulWidget {
  const WidgetSettingsPage({super.key});

  @override
  ConsumerState<WidgetSettingsPage> createState() => _WidgetSettingsPageState();
}

class _WidgetSettingsPageState extends ConsumerState<WidgetSettingsPage> {
  late List<HomeWidgetConfig> _widgets;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(launcherProvider).settings;
    _widgets = HomeWidgetConfigList.decode(settings.homeWidgetsJson);
  }

  Future<void> _save() async {
    await ref.read(launcherProvider.notifier).updateWidgets(_widgets);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Home Widgets',
            style: t.type.headline.copyWith(color: t.primaryText)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: NudgeSpacing.sm),
            child: TextButton(
              onPressed: () async {
                setState(() => _widgets = HomeWidgetConfigList.defaults);
                await _save();
              },
              child: Text('Reset',
                  style: t.type.caption.copyWith(color: t.accent)),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                NudgeSpacing.lg, NudgeSpacing.sm, NudgeSpacing.lg, NudgeSpacing.md),
            child: Text(
              'Drag to reorder. Toggle visibility with the switch. Changes save automatically.',
              style: t.type.caption.copyWith(color: t.mutedText),
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: NudgeSpacing.lg),
              itemCount: _widgets.length,
              onReorder: (oldIndex, newIndex) {
                HapticFeedback.selectionClick();
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final item = _widgets.removeAt(oldIndex);
                  _widgets.insert(newIndex, item);
                });
                _save();
              },
              itemBuilder: (context, index) {
                final widget = _widgets[index];
                return _WidgetTile(
                  key: ValueKey(widget.type),
                  config: widget,
                  theme: t,
                  onToggle: (val) {
                    setState(() => widget.visible = val);
                    _save();
                  },
                );
              },
            ),
          ),
          _SpacingAlignmentSection(theme: t),
        ],
      ),
    );
  }
}

class _WidgetTile extends StatelessWidget {
  const _WidgetTile({
    super.key,
    required this.config,
    required this.theme,
    required this.onToggle,
  });

  final HomeWidgetConfig config;
  final NudgeThemeData theme;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final t = theme;
    return Container(
      margin: const EdgeInsets.only(bottom: NudgeSpacing.sm),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: t.divider),
      ),
      child: ListTile(
        leading: Icon(Icons.drag_handle, color: t.mutedText),
        title: Text(config.type.label,
            style: t.type.body.copyWith(color: t.primaryText)),
        subtitle: Text(config.type.description,
            style: t.type.caption.copyWith(color: t.mutedText)),
        trailing: Switch(
          value: config.visible,
          activeColor: t.accent,
          onChanged: onToggle,
        ),
      ),
    );
  }
}

class _SpacingAlignmentSection extends ConsumerWidget {
  const _SpacingAlignmentSection({required this.theme});

  final NudgeThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = theme;
    final settings = ref.watch(launcherProvider).settings;
    final notifier = ref.read(launcherProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(NudgeSpacing.lg),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: t.divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spacing slider
          Row(
            children: [
              Text('Spacing', style: t.type.body.copyWith(color: t.primaryText)),
              const Spacer(),
              Text('${settings.widgetSpacing.round()}px',
                  style: t.type.caption.copyWith(color: t.mutedText)),
            ],
          ),
          Slider(
            value: settings.widgetSpacing,
            min: 0,
            max: 32,
            divisions: 8,
            activeColor: t.accent,
            inactiveColor: t.divider,
            onChanged: (v) => notifier.updateWidgetSpacing(v),
          ),
          const SizedBox(height: NudgeSpacing.sm),
          // Alignment
          Text('Alignment', style: t.type.body.copyWith(color: t.primaryText)),
          const SizedBox(height: NudgeSpacing.xs),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'left', label: Text('Left')),
              ButtonSegment(value: 'center', label: Text('Center')),
              ButtonSegment(value: 'right', label: Text('Right')),
            ],
            selected: {settings.widgetAlignment},
            onSelectionChanged: (s) => notifier.updateWidgetAlignment(s.first),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return t.accent;
                return t.surface;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return t.background;
                return t.primaryText;
              }),
              side: WidgetStateProperty.all(BorderSide(color: t.divider)),
            ),
          ),
        ],
      ),
    );
  }
}
