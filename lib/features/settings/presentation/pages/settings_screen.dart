// ignore_for_file: deprecated_member_use
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/theme_presets.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../../core/theme/nudge_typography.dart';
import '../../../../core/theme/nudge_colors.dart';
import '../../../../features/customization/domain/models/theme_config.dart';
import '../../../../core/database/database_service.dart';
import '../../../../features/focus/presentation/pages/focus_settings_screen.dart';
import '../../../../features/usage/presentation/pages/dashboard_screen.dart';

// Helper extensions for styling.
extension SettingsThemeExtension on BuildContext {
  NudgeThemeData get theme => NudgeTheme.of(this);
}

/// Root customization screen providing navigation to all appearance sub-sections.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.theme;

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
          'Settings',
          style: t.type.headline.copyWith(color: t.primaryText),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: NudgePreviewWidget(),
            ),
            _buildSectionHeader(context, 'Customization'),
            _buildTile(
              context,
              icon: NudgeIconToken.palette,
              title: 'Themes',
              subtitle: 'Manage presets & custom themes',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ThemesPage()),
              ),
            ),
            _buildTile(
              context,
              icon: NudgeIconToken.font,
              title: 'Typography',
              subtitle: 'Font families, weights, scaling',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TypographySettingsPage()),
              ),
            ),
            _buildTile(
              context,
              icon: NudgeIconToken.grid,
              title: 'Icons',
              subtitle: 'Icon packs, sizing, thickness',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IconSettingsPage()),
              ),
            ),
            _buildTile(
              context,
              icon: NudgeIconToken.theme,
              title: 'Colors',
              subtitle: 'Solid backgrounds & contrast safe text',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ColorSettingsPage()),
              ),
            ),
            _buildTile(
              context,
              icon: NudgeIconToken.apps,
              title: 'Layout',
              subtitle: 'Padding, density, app alignment',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LayoutSettingsPage()),
              ),
            ),
            _buildTile(
              context,
              icon: NudgeIconToken.clock,
              title: 'Clock & Date',
              subtitle: 'Formats, seconds, alignment',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ClockSettingsPage()),
              ),
            ),
            _buildTile(
              context,
              icon: NudgeIconToken.device,
              title: 'Motion & Haptics',
              subtitle: 'Animation speed, haptic feedback',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MotionSettingsPage()),
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionHeader(context, 'Digital Wellbeing'),
            _buildTile(
              context,
              icon: NudgeIconToken.focus,
              title: 'Focus & Block Rules',
              subtitle: 'App blocking, delays, scheduled rules',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FocusSettingsPage()),
              ),
            ),
            _buildTile(
              context,
              icon: NudgeIconToken.success,
              title: 'Wellbeing Dashboard',
              subtitle: 'Screen time, launches, focus score',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final t = context.theme;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 4.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: t.mutedText,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required NudgeIconToken icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final t = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: t.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: t.divider),
          ),
          child: Row(
            children: [
              Icon(t.icons.resolve(icon), color: t.accent, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: t.type.title.copyWith(color: t.primaryText),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: t.type.caption.copyWith(color: t.secondaryText),
                    ),
                  ],
                ),
              ),
              Icon(
                t.icons.resolve(NudgeIconToken.chevronRight),
                color: t.mutedText,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Live preview widget showing the clock and dynamic list layout in a simulated phone frame.
class NudgePreviewWidget extends ConsumerWidget {
  const NudgePreviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(nudgeThemeDataProvider);

    // Dynamic mock date string formatting
    final now = DateTime.now();
    final String timeStr;
    if (t.clockSettings.clockFormat == '12') {
      final hour = now.hour == 0 ? 12 : (now.hour > 12 ? now.hour - 12 : now.hour);
      final period = now.hour >= 12 ? 'PM' : 'AM';
      final min = now.minute.toString().padLeft(2, '0');
      final sec = t.clockSettings.showSeconds ? ':${now.second.toString().padLeft(2, '0')}' : '';
      timeStr = '$hour:$min$sec $period';
    } else {
      final hour = now.hour.toString().padLeft(2, '0');
      final min = now.minute.toString().padLeft(2, '0');
      final sec = t.clockSettings.showSeconds ? ':${now.second.toString().padLeft(2, '0')}' : '';
      timeStr = '$hour:$min$sec';
    }

    final dateStr = '${now.day}/${now.month}/${now.year}';

    // Alignment mapping
    TextAlign textAlignment = TextAlign.left;
    if (t.layoutSettings.alignment == Alignment.center) {
      textAlignment = TextAlign.center;
    } else if (t.layoutSettings.alignment == Alignment.centerRight) {
      textAlignment = TextAlign.right;
    }

    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        color: t.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: t.divider, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: t.layoutSettings.horizontalPadding / 2,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (t.layoutSettings.clockPosition == 'top') ...[
                _buildClockSection(t, timeStr, dateStr),
                SizedBox(height: t.layoutSettings.verticalSpacing),
              ],
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildPreviewAppRow(t, 'Camera', NudgeIconToken.eye, textAlignment),
                    SizedBox(height: t.layoutSettings.density.itemSpacing),
                    _buildPreviewAppRow(t, 'Messages', NudgeIconToken.notification, textAlignment),
                    SizedBox(height: t.layoutSettings.density.itemSpacing),
                    _buildPreviewAppRow(t, 'Settings', NudgeIconToken.settings, textAlignment),
                  ],
                ),
              ),
              if (t.layoutSettings.clockPosition == 'bottom') ...[
                SizedBox(height: t.layoutSettings.verticalSpacing),
                _buildClockSection(t, timeStr, dateStr),
              ],
            ],
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
            fontSize: 28 * t.clockSettings.clockSizeScale,
            fontWeight: t.clockSettings.clockFontWeight != null
                ? FontWeight.values.firstWhere((w) => w.value == t.clockSettings.clockFontWeight)
                : t.type.display.fontWeight,
            color: t.primaryText,
          ),
        ),
        if (t.clockSettings.showDate) ...[
          const SizedBox(height: 2),
          Text(
            dateStr,
            textAlign: clockTextAlign,
            style: t.type.caption.copyWith(color: t.secondaryText),
          ),
        ],
      ],
    );
  }

  Widget _buildPreviewAppRow(
    NudgeThemeData t,
    String name,
    NudgeIconToken iconToken,
    TextAlign textAlignment,
  ) {
    final textStyle = t.type.body.copyWith(color: t.primaryText);
    final formattedName = t.type.applyCase(name);

    return Align(
      alignment: t.layoutSettings.alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (t.layoutSettings.showIcons) ...[
            Opacity(
              opacity: t.iconSettings.opacity,
              child: Icon(
                t.icons.resolve(iconToken),
                size: t.iconSettings.size,
                color: t.iconSettings.colorOverride ?? t.primaryText,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            formattedName,
            style: textStyle,
            textAlign: textAlignment,
          ),
        ],
      ),
    );
  }
}

/// Settings subpage for managing typography.
class TypographySettingsPage extends ConsumerWidget {
  const TypographySettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.theme;
    final config = ref.watch(activeThemeConfigProvider);
    final notifier = ref.read(nudgeThemeProvider.notifier);

    final family = NudgeFontFamily.parse(config.fontFamily);

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Typography', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const NudgePreviewWidget(),
          const SizedBox(height: 24),
          _buildCard(
            context,
            title: 'Font Family',
            child: Column(
              children: NudgeFontFamily.values.map((f) {
                final isSelected = f.id == config.fontFamily;
                return RadioListTile<String>(
                  title: Text(
                    f.id == 'system' ? 'Android System Font' : f.id,
                    style: TextStyle(
                      fontFamily: f.fontFamilyName,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: t.primaryText,
                    ),
                  ),
                  value: f.id,
                  groupValue: config.fontFamily,
                  activeColor: t.accent,
                  onChanged: (val) {
                    if (val != null) {
                      notifier.updateField((cfg) => cfg.fontFamily = val);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'Weight',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected weight: ${config.fontWeight}',
                  style: t.type.body.copyWith(color: t.secondaryText),
                ),
                Slider(
                  value: config.fontWeight.toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor: t.accent,
                  inactiveColor: t.divider,
                  onChanged: (val) {
                    notifier.updateField((cfg) => cfg.fontWeight = val.round());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Available weights for this font: ${family.availableWeights.map((w) => w.value).join(', ')}',
                    style: t.type.caption.copyWith(color: t.mutedText),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'Text Scale & Alignment',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSliderRow(
                  context,
                  label: 'Font Size Scale',
                  value: config.fontSizeScale,
                  min: 0.8,
                  max: 1.5,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.fontSizeScale = val),
                ),
                _buildSliderRow(
                  context,
                  label: 'Letter Spacing',
                  value: config.letterSpacingDelta,
                  min: -0.5,
                  max: 2.0,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.letterSpacingDelta = val),
                ),
                _buildSliderRow(
                  context,
                  label: 'Line Height Scale',
                  value: config.lineHeightScale,
                  min: 0.9,
                  max: 2.0,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.lineHeightScale = val),
                ),
                const SizedBox(height: 12),
                Text('Text Alignment', style: t.type.label.copyWith(color: t.secondaryText)),
                const SizedBox(height: 8),
                Row(
                  children: ['left', 'center', 'right'].map((align) {
                    final isSelected = config.textAlignment == align;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(align.toUpperCase(), style: TextStyle(color: isSelected ? Colors.white : t.primaryText)),
                          selected: isSelected,
                          selectedColor: t.accent,
                          backgroundColor: t.surface,
                          onSelected: (selected) {
                            if (selected) {
                              notifier.updateField((cfg) => cfg.textAlignment = align);
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text('Text Case', style: t.type.label.copyWith(color: t.secondaryText)),
                const SizedBox(height: 8),
                Row(
                  children: ['none', 'upper', 'lower'].map((tc) {
                    final isSelected = config.textCase == tc;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(tc.toUpperCase(), style: TextStyle(color: isSelected ? Colors.white : t.primaryText)),
                          selected: isSelected,
                          selectedColor: t.accent,
                          backgroundColor: t.surface,
                          onSelected: (selected) {
                            if (selected) {
                              notifier.updateField((cfg) => cfg.textCase = tc);
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required Widget child}) {
    final t = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildSliderRow(
    BuildContext context, {
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    final t = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: t.type.label.copyWith(color: t.secondaryText)),
              Text(value.toStringAsFixed(2), style: t.type.label.copyWith(color: t.primaryText)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: t.accent,
            inactiveColor: t.divider,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Settings subpage for managing icons.
class IconSettingsPage extends ConsumerWidget {
  const IconSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.theme;
    final config = ref.watch(activeThemeConfigProvider);
    final notifier = ref.read(nudgeThemeProvider.notifier);

    final supportsThickness = config.iconPack == 'lucide' || config.iconPack == 'phosphor' || config.iconPack == 'tabler';
    final supportsStyle = config.iconPack == 'phosphor' || config.iconPack == 'material';

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Icons', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const NudgePreviewWidget(),
          const SizedBox(height: 24),
          _buildCard(
            context,
            title: 'Icon Pack',
            child: Column(
              children: NudgeIconPack.values.map((p) {
                final isSelected = p.name == config.iconPack;
                return RadioListTile<String>(
                  title: Text(p.label, style: t.type.body.copyWith(color: t.primaryText)),
                  value: p.name,
                  groupValue: config.iconPack,
                  activeColor: t.accent,
                  onChanged: (val) {
                    if (val != null) {
                      notifier.updateField((cfg) => cfg.iconPack = val);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'Icon Settings',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSliderRow(
                  context,
                  label: 'Icon Size',
                  value: config.iconSize,
                  min: 16,
                  max: 40,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.iconSize = val),
                ),
                _buildSliderRow(
                  context,
                  label: 'Icon Opacity',
                  value: config.iconOpacity,
                  min: 0.3,
                  max: 1.0,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.iconOpacity = val),
                ),
                Opacity(
                  opacity: supportsThickness ? 1.0 : 0.4,
                  child: _buildSliderRow(
                    context,
                    label: 'Stroke Thickness (Where supported)',
                    value: config.iconThickness,
                    min: 1.0,
                    max: 2.5,
                    onChanged: supportsThickness
                        ? (val) => notifier.updateField((cfg) => cfg.iconThickness = val)
                        : (val) {},
                  ),
                ),
                if (!supportsThickness)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 8),
                    child: Text('This pack does not support thickness control.', style: t.type.caption.copyWith(color: t.mutedText)),
                  ),
                const SizedBox(height: 12),
                Opacity(
                  opacity: supportsStyle ? 1.0 : 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Icon Style (Where supported)', style: t.type.label.copyWith(color: t.secondaryText)),
                      const SizedBox(height: 8),
                      Row(
                        children: ['outline', 'filled'].map((styleOpt) {
                          final isSelected = config.iconStyle == styleOpt;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                label: Text(styleOpt.toUpperCase(), style: TextStyle(color: isSelected ? Colors.white : t.primaryText)),
                                selected: isSelected,
                                selectedColor: t.accent,
                                backgroundColor: t.surface,
                                onSelected: supportsStyle
                                    ? (selected) {
                                        if (selected) {
                                          notifier.updateField((cfg) => cfg.iconStyle = styleOpt);
                                        }
                                      }
                                    : (selected) {},
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required Widget child}) {
    final t = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildSliderRow(
    BuildContext context, {
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    final t = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: t.type.label.copyWith(color: t.secondaryText)),
              Text(value.toStringAsFixed(2), style: t.type.label.copyWith(color: t.primaryText)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: t.accent,
            inactiveColor: t.divider,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Settings subpage for colors.
class ColorSettingsPage extends ConsumerStatefulWidget {
  const ColorSettingsPage({super.key});

  @override
  ConsumerState<ColorSettingsPage> createState() => _ColorSettingsPageState();
}

class _ColorSettingsPageState extends ConsumerState<ColorSettingsPage> {
  final TextEditingController _bgController = TextEditingController();
  final TextEditingController _primaryController = TextEditingController();
  final TextEditingController _secondaryController = TextEditingController();
  final TextEditingController _accentController = TextEditingController();

  // Curated modern color palettes
  final List<Color> _curatedBgs = [
    const Color(0xFF0B0B0F), // Dark Grey
    const Color(0xFF000000), // Pure Black
    const Color(0xFF18181C), // Medium Grey
    const Color(0xFFFAFAF8), // Off-white Paper
    const Color(0xFFFAF6EE), // Cream
    const Color(0xFFF5F3FF), // Soft Purple tint
  ];

  final List<Color> _curatedAccents = [
    const Color(0xFF7C5CFC), // Nudge Purple
    const Color(0xFFFF2F2F), // Nothing Red
    const Color(0xFF39FF88), // Terminal Green
    const Color(0xFF5C42D8), // Deep Indigo
    const Color(0xFFFFBF00), // Amber
    const Color(0xFFE25B8B), // Rose
  ];

  @override
  void initState() {
    super.initState();
    final config = ref.read(activeThemeConfigProvider);
    _bgController.text = _toHex(config.backgroundColorValue ?? 0xFF0B0B0F);
    _primaryController.text = _toHex(config.primaryTextColorValue ?? 0xFFF5F5F7);
    _secondaryController.text = _toHex(config.secondaryTextColorValue ?? 0xFFA1A1AA);
    _accentController.text = _toHex(config.accentColorValue ?? 0xFF8B6CFF);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _primaryController.dispose();
    _secondaryController.dispose();
    _accentController.dispose();
    super.dispose();
  }

  String _toHex(int value) {
    return '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  int? _parseHex(String text) {
    final hex = text.replaceAll('#', '').trim();
    if (hex.length == 6) {
      return int.tryParse('FF$hex', radix: 16);
    } else if (hex.length == 8) {
      return int.tryParse(hex, radix: 16);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.theme;
    final config = ref.watch(activeThemeConfigProvider);
    final notifier = ref.read(nudgeThemeProvider.notifier);

    // Calculate contrast warning
    final bg = Color(config.backgroundColorValue ?? 0xFF0B0B0F);
    final primary = Color(config.primaryTextColorValue ?? 0xFFF5F5F7);
    final ratio = NudgeColorScheme.contrastRatio(bg, primary);
    final hasLowContrast = ratio < 4.5;

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Colors', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const NudgePreviewWidget(),
          const SizedBox(height: 16),
          if (hasLowContrast)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: t.semanticColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: t.semanticColors.error.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(t.icons.resolve(NudgeIconToken.warning), color: t.semanticColors.error),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Low Contrast warning (Ratio: ${ratio.toStringAsFixed(1)}:1). Primary text will be dynamically adjusted to ensure readable contrast (min 4.5:1).',
                      style: t.type.caption.copyWith(color: t.semanticColors.error),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'Preset Mode',
            child: Column(
              children: ['light', 'dark', 'oled', 'custom'].map((mode) {
                final isSelected = config.colorPreset == mode;
                return RadioListTile<String>(
                  title: Text(mode.toUpperCase(), style: t.type.body.copyWith(color: t.primaryText)),
                  value: mode,
                  groupValue: config.colorPreset,
                  activeColor: t.accent,
                  onChanged: (val) {
                    if (val != null) {
                      notifier.updateField((cfg) => cfg.colorPreset = val);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          if (config.colorPreset == 'custom') ...[
            const SizedBox(height: 16),
            _buildCard(
              context,
              title: 'Custom Palette Creator',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildColorPickerRow(
                    context,
                    label: 'Background Color',
                    controller: _bgController,
                    curatedList: _curatedBgs,
                    onSelected: (val) {
                      _bgController.text = _toHex(val.value);
                      notifier.updateField((cfg) => cfg.backgroundColorValue = val.value);
                    },
                    onSubmitted: (text) {
                      final val = _parseHex(text);
                      if (val != null) {
                        notifier.updateField((cfg) => cfg.backgroundColorValue = val);
                      }
                    },
                  ),
                  const Divider(height: 32),
                  _buildColorPickerRow(
                    context,
                    label: 'Primary Text Color',
                    controller: _primaryController,
                    curatedList: const [Color(0xFFFFFFFF), Color(0xFFF5F5F7), Color(0xFF17171C), Color(0xFF222222)],
                    onSelected: (val) {
                      _primaryController.text = _toHex(val.value);
                      notifier.updateField((cfg) => cfg.primaryTextColorValue = val.value);
                    },
                    onSubmitted: (text) {
                      final val = _parseHex(text);
                      if (val != null) {
                        notifier.updateField((cfg) => cfg.primaryTextColorValue = val);
                      }
                    },
                  ),
                  const Divider(height: 32),
                  _buildColorPickerRow(
                    context,
                    label: 'Accent Color',
                    controller: _accentController,
                    curatedList: _curatedAccents,
                    onSelected: (val) {
                      _accentController.text = _toHex(val.value);
                      notifier.updateField((cfg) => cfg.accentColorValue = val.value);
                    },
                    onSubmitted: (text) {
                      final val = _parseHex(text);
                      if (val != null) {
                        notifier.updateField((cfg) => cfg.accentColorValue = val);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required Widget child}) {
    final t = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildColorPickerRow(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required List<Color> curatedList,
    required ValueChanged<Color> onSelected,
    required ValueChanged<String> onSubmitted,
  }) {
    final t = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: t.type.label.copyWith(color: t.secondaryText)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: curatedList.length,
                  itemBuilder: (context, index) {
                    final color = curatedList[index];
                    return GestureDetector(
                      onTap: () => onSelected(color),
                      child: Container(
                        width: 32,
                        height: 32,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(color: t.divider, width: 1.5),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              height: 40,
              child: TextField(
                controller: controller,
                style: t.type.label.copyWith(color: t.primaryText),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  hintText: '#HEX',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onSubmitted: onSubmitted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Settings subpage for layout configuration.
class LayoutSettingsPage extends ConsumerWidget {
  const LayoutSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.theme;
    final config = ref.watch(activeThemeConfigProvider);
    final notifier = ref.read(nudgeThemeProvider.notifier);

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Layout', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const NudgePreviewWidget(),
          const SizedBox(height: 24),
          _buildCard(
            context,
            title: 'Sizing & Padding',
            child: Column(
              children: [
                _buildSliderRow(
                  context,
                  label: 'Horizontal Padding',
                  value: config.horizontalPadding,
                  min: 12,
                  max: 48,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.horizontalPadding = val),
                ),
                _buildSliderRow(
                  context,
                  label: 'Vertical Item Spacing',
                  value: config.verticalSpacing,
                  min: 4,
                  max: 32,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.verticalSpacing = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'App Grid / List Configuration',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App List Density', style: t.type.label.copyWith(color: t.secondaryText)),
                const SizedBox(height: 8),
                Row(
                  children: ['compact', 'normal', 'comfortable'].map((density) {
                    final isSelected = config.appDensity == density;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(density.toUpperCase(), style: TextStyle(color: isSelected ? Colors.white : t.primaryText)),
                          selected: isSelected,
                          selectedColor: t.accent,
                          backgroundColor: t.surface,
                          onSelected: (selected) {
                            if (selected) {
                              notifier.updateField((cfg) => cfg.appDensity = density);
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text('App List Alignment', style: t.type.label.copyWith(color: t.secondaryText)),
                const SizedBox(height: 8),
                Row(
                  children: ['left', 'center', 'right'].map((align) {
                    final isSelected = config.appAlignment == align;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(align.toUpperCase(), style: TextStyle(color: isSelected ? Colors.white : t.primaryText)),
                          selected: isSelected,
                          selectedColor: t.accent,
                          backgroundColor: t.surface,
                          onSelected: (selected) {
                            if (selected) {
                              notifier.updateField((cfg) => cfg.appAlignment = align);
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Visible Favorites Count', style: t.type.label.copyWith(color: t.secondaryText)),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: t.primaryText),
                          onPressed: config.visibleAppCount > 3
                              ? () => notifier.updateField((cfg) => cfg.visibleAppCount--)
                              : null,
                        ),
                        Text('${config.visibleAppCount}', style: t.type.body.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: Icon(Icons.add, color: t.primaryText),
                          onPressed: config.visibleAppCount < 12
                              ? () => notifier.updateField((cfg) => cfg.visibleAppCount++)
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: Text('Show App Icons', style: t.type.body.copyWith(color: t.primaryText)),
                  value: config.showIcons,
                  activeColor: t.accent,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.showIcons = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'Clock Placement',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Clock Position', style: t.type.label.copyWith(color: t.secondaryText)),
                const SizedBox(height: 8),
                Row(
                  children: ['top', 'bottom', 'hidden'].map((pos) {
                    final isSelected = config.clockPosition == pos;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(pos.toUpperCase(), style: TextStyle(color: isSelected ? Colors.white : t.primaryText)),
                          selected: isSelected,
                          selectedColor: t.accent,
                          backgroundColor: t.surface,
                          onSelected: (selected) {
                            if (selected) {
                              notifier.updateField((cfg) => cfg.clockPosition = pos);
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required Widget child}) {
    final t = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildSliderRow(
    BuildContext context, {
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    final t = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: t.type.label.copyWith(color: t.secondaryText)),
              Text(value.toStringAsFixed(2), style: t.type.label.copyWith(color: t.primaryText)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: t.accent,
            inactiveColor: t.divider,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Settings subpage for Clock configuration.
class ClockSettingsPage extends ConsumerWidget {
  const ClockSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.theme;
    final config = ref.watch(activeThemeConfigProvider);
    final notifier = ref.read(nudgeThemeProvider.notifier);

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Clock & Date', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const NudgePreviewWidget(),
          const SizedBox(height: 24),
          _buildCard(
            context,
            title: 'Time Settings',
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('24 Hour Format', style: t.type.body.copyWith(color: t.primaryText)),
                  value: config.clockFormat == '24',
                  activeColor: t.accent,
                  onChanged: (val) {
                    notifier.updateField((cfg) => cfg.clockFormat = val ? '24' : '12');
                  },
                ),
                SwitchListTile(
                  title: Text('Show Seconds', style: t.type.body.copyWith(color: t.primaryText)),
                  value: config.showSeconds,
                  activeColor: t.accent,
                  onChanged: (val) {
                    notifier.updateField((cfg) => cfg.showSeconds = val);
                  },
                ),
                _buildSliderRow(
                  context,
                  label: 'Clock Size Scale',
                  value: config.clockSizeScale,
                  min: 0.6,
                  max: 2.0,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.clockSizeScale = val),
                ),
                const SizedBox(height: 12),
                Text('Clock Alignment', style: t.type.label.copyWith(color: t.secondaryText)),
                const SizedBox(height: 8),
                Row(
                  children: ['left', 'center', 'right'].map((align) {
                    final isSelected = config.clockAlignment == align;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(align.toUpperCase(), style: TextStyle(color: isSelected ? Colors.white : t.primaryText)),
                          selected: isSelected,
                          selectedColor: t.accent,
                          backgroundColor: t.surface,
                          onSelected: (selected) {
                            if (selected) {
                              notifier.updateField((cfg) => cfg.clockAlignment = align);
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'Date Settings',
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Show Date', style: t.type.body.copyWith(color: t.primaryText)),
                  value: config.showDate,
                  activeColor: t.accent,
                  onChanged: (val) {
                    notifier.updateField((cfg) => cfg.showDate = val);
                  },
                ),
                if (config.showDate) ...[
                  const SizedBox(height: 12),
                  Text('Date Format Pattern', style: t.type.label.copyWith(color: t.secondaryText)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: config.dateFormat,
                    dropdownColor: t.surface,
                    style: t.type.body.copyWith(color: t.primaryText),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'EEE, MMM d', child: Text('Mon, Aug 16')),
                      DropdownMenuItem(value: 'EEEE, MMMM d', child: Text('Monday, August 16')),
                      DropdownMenuItem(value: 'dd/MM/yyyy', child: Text('16/08/2026')),
                      DropdownMenuItem(value: 'yyyy-MM-dd', child: Text('2026-08-16')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        notifier.updateField((cfg) => cfg.dateFormat = val);
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required Widget child}) {
    final t = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildSliderRow(
    BuildContext context, {
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    final t = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: t.type.label.copyWith(color: t.secondaryText)),
              Text(value.toStringAsFixed(2), style: t.type.label.copyWith(color: t.primaryText)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: t.accent,
            inactiveColor: t.divider,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Settings subpage for animations and haptics.
class MotionSettingsPage extends ConsumerWidget {
  const MotionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.theme;
    final config = ref.watch(activeThemeConfigProvider);
    final notifier = ref.read(nudgeThemeProvider.notifier);

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Motion & Haptics', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildCard(
            context,
            title: 'Animation Mode',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: ['none', 'calm', 'smooth'].map((mode) {
                    final isSelected = config.motionMode == mode;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(mode.toUpperCase(), style: TextStyle(color: isSelected ? Colors.white : t.primaryText)),
                          selected: isSelected,
                          selectedColor: t.accent,
                          backgroundColor: t.surface,
                          onSelected: (selected) {
                            if (selected) {
                              notifier.updateField((cfg) => cfg.motionMode = mode);
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                _buildSliderRow(
                  context,
                  label: 'Animation Speed Scale',
                  value: config.animationSpeedScale,
                  min: 0.5,
                  max: 2.0,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.animationSpeedScale = val),
                ),
                SwitchListTile(
                  title: Text('Accessibility: Reduced Motion', style: t.type.body.copyWith(color: t.primaryText)),
                  subtitle: Text('Overrides and disables all UI animations', style: t.type.caption.copyWith(color: t.secondaryText)),
                  value: config.reducedMotion,
                  activeColor: t.accent,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.reducedMotion = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'Haptic Feedback',
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Enable Haptic Feedback', style: t.type.body.copyWith(color: t.primaryText)),
                  subtitle: Text('Triggers gentle vibrations on app launching & settings taps', style: t.type.caption.copyWith(color: t.secondaryText)),
                  value: config.hapticFeedback,
                  activeColor: t.accent,
                  onChanged: (val) => notifier.updateField((cfg) => cfg.hapticFeedback = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required Widget child}) {
    final t = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildSliderRow(
    BuildContext context, {
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    final t = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: t.type.label.copyWith(color: t.secondaryText)),
              Text(value.toStringAsFixed(2), style: t.type.label.copyWith(color: t.primaryText)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: t.accent,
            inactiveColor: t.divider,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Settings subpage for managing theme configurations.
class ThemesPage extends ConsumerStatefulWidget {
  const ThemesPage({super.key});

  @override
  ConsumerState<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends ConsumerState<ThemesPage> {
  final TextEditingController _nameController = TextEditingController();
  List<ThemeConfig> _themes = [];

  @override
  void initState() {
    super.initState();
    _loadThemes();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadThemes() async {
    final list = await ref.read(nudgeThemeProvider.notifier).getAllThemes();
    setState(() {
      _themes = list;
    });
  }

  void _showSaveThemeDialog(BuildContext context) {
    final t = context.theme;
    _nameController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: t.surface,
          title: Text('Save Current Theme', style: t.type.title.copyWith(color: t.primaryText)),
          content: TextField(
            controller: _nameController,
            style: t.type.body.copyWith(color: t.primaryText),
            decoration: InputDecoration(
              hintText: 'Theme Name',
              hintStyle: TextStyle(color: t.mutedText),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: t.accent)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: t.mutedText)),
            ),
            TextButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                if (name.isNotEmpty) {
                  await ref.read(nudgeThemeProvider.notifier).saveCustomTheme(name);
                  await _loadThemes();
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: Text('Save', style: TextStyle(color: t.accent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.theme;
    final notifier = ref.read(nudgeThemeProvider.notifier);
    final activeConfig = ref.watch(activeThemeConfigProvider);

    final presets = _themes.where((th) => !th.isCustom).toList();
    final customs = _themes.where((th) => th.isCustom).toList();

    return Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(t.icons.resolve(NudgeIconToken.arrowBack), color: t.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Themes', style: t.type.headline.copyWith(color: t.primaryText)),
        actions: [
          IconButton(
            icon: Icon(t.icons.resolve(NudgeIconToken.add), color: t.primaryText),
            onPressed: () => _showSaveThemeDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildSectionHeader('Preset Themes'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemCount: NudgeThemePreset.values.length,
            itemBuilder: (context, index) {
              final p = NudgeThemePreset.values[index];
              final isApplied = activeConfig.name == p.label && !activeConfig.isCustom;

              return GestureDetector(
                onTap: () async {
                  await notifier.setPreset(p);
                  await _loadThemes();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: t.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isApplied ? t.accent : t.divider,
                      width: isApplied ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(p.label, style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
                      Text(p.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: t.type.caption.copyWith(color: t.secondaryText)),
                    ],
                  ),
                ),
              );
            },
          ),
          if (customs.isNotEmpty) ...[
            const SizedBox(height: 32),
            _buildSectionHeader('Your Custom Themes'),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: customs.length,
              itemBuilder: (context, index) {
                final custom = customs[index];
                final isApplied = activeConfig.id == custom.id;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: t.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isApplied ? t.accent : t.divider,
                        width: isApplied ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(custom.name, style: t.type.body.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () async {
                                await notifier.applyConfig(custom);
                                await _loadThemes();
                              },
                              child: Text('Apply', style: TextStyle(color: isApplied ? t.accent : t.secondaryText)),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: t.semanticColors.error, size: 20),
                              onPressed: () async {
                                await notifier.deleteCustomTheme(custom.id);
                                await _loadThemes();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: t.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              await notifier.resetToDefault();
              await _loadThemes();
            },
            child: Text('Reset Current Theme to Default', style: t.type.body.copyWith(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final t = context.theme;
    return Text(
      title,
      style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold),
    );
  }
}
