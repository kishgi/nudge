import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/theme_provider.dart';

/// Dedicated accessibility settings page supporting High Contrast, Reduced Motion,
/// Haptics, and Screen Reader accessibility features.
class AccessibilitySettingsPage extends ConsumerWidget {
  const AccessibilitySettingsPage({super.key});

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
        title: Text('Accessibility', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(NudgeSpacing.lg),
        children: [
          Text(
            'Nudge is built for absolute clarity and accessible digital wellbeing for everyone.',
            style: t.type.body.copyWith(color: t.mutedText),
          ),
          const SizedBox(height: NudgeSpacing.xl),

          // High Contrast Mode
          _buildToggleCard(
            context,
            icon: Icons.contrast,
            title: 'High Contrast Mode',
            subtitle: 'Enforces WCAG AAA black/white background and high-contrast text colors.',
            value: config.highContrast,
            onChanged: (val) {
              HapticFeedback.selectionClick();
              final updated = themeState.config..highContrast = val;
              themeNotifier.applyConfig(updated);
            },
          ),
          const SizedBox(height: NudgeSpacing.md),

          // Reduced Motion
          _buildToggleCard(
            context,
            icon: Icons.motion_photos_off,
            title: 'Reduced Motion',
            subtitle: 'Disables all transition animations and screen motion effects.',
            value: config.reducedMotion,
            onChanged: (val) {
              HapticFeedback.selectionClick();
              final updated = themeState.config..reducedMotion = val;
              themeNotifier.applyConfig(updated);
            },
          ),
          const SizedBox(height: NudgeSpacing.md),

          // Haptic Feedback
          _buildToggleCard(
            context,
            icon: Icons.vibration,
            title: 'Haptic Feedback',
            subtitle: 'Vibrates lightly when performing gestures, taps, and drag actions.',
            value: config.hapticFeedback,
            onChanged: (val) {
              HapticFeedback.selectionClick();
              final updated = themeState.config..hapticFeedback = val;
              themeNotifier.applyConfig(updated);
            },
          ),
          const SizedBox(height: NudgeSpacing.xl),

          // Accessibility Information & Guidelines
          Text('Accessibility Features', style: t.type.body.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: NudgeSpacing.sm),

          _buildInfoTile(
            context,
            icon: Icons.format_size,
            title: 'Android Font Scaling',
            subtitle: 'Nudge automatically inherits Android system font scale settings up to 2.0x without clipping layout bounds.',
          ),
          _buildInfoTile(
            context,
            icon: Icons.touch_app,
            title: 'Adequate Touch Targets',
            subtitle: 'All interactive elements, buttons, and app drawer items maintain a minimum 48x48 dp touch target area.',
          ),
          _buildInfoTile(
            context,
            icon: Icons.record_voice_over,
            title: 'Screen Reader Semantics',
            subtitle: 'Includes full Semantics labels, hints, and button tags for TalkBack and screen reader accessibility.',
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final t = context.nudgeTheme;
    return Container(
      padding: const EdgeInsets.all(NudgeSpacing.md),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: t.divider),
      ),
      child: Row(
        children: [
          Icon(icon, color: t.accent, size: 24),
          const SizedBox(width: NudgeSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: t.type.body.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: t.type.caption.copyWith(color: t.secondaryText)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: t.accent,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final t = context.nudgeTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: NudgeSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: t.mutedText, size: 20),
          const SizedBox(width: NudgeSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: t.type.caption.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
                Text(subtitle, style: t.type.caption.copyWith(color: t.mutedText)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
