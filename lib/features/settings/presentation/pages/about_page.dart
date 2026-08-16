import 'package:flutter/material.dart';

import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../../core/theme/nudge_spacing.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
        title: Text('About Nudge', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(NudgeSpacing.lg),
        children: [
          // App Logo / Title Banner
          Center(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: t.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: t.accent.withValues(alpha: 0.4)),
                  ),
                  child: Icon(t.icons.resolve(NudgeIconToken.focus), color: t.accent, size: 40),
                ),
                const SizedBox(height: NudgeSpacing.md),
                Text(
                  'NUDGE',
                  style: t.type.display.copyWith(
                    color: t.primaryText,
                    letterSpacing: 4.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Version 1.0.0 (Minimalist Launcher)',
                  style: t.type.caption.copyWith(color: t.mutedText),
                ),
              ],
            ),
          ),

          const SizedBox(height: NudgeSpacing.xxl),

          // Core Principles
          Text('Core Design Principles', style: t.type.body.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: NudgeSpacing.md),

          _buildPrincipleCard(
            context,
            t,
            title: 'Friction by Design',
            subtitle: 'Breathing delays and focus rules break mindless notification loops.',
          ),
          const SizedBox(height: NudgeSpacing.sm),
          _buildPrincipleCard(
            context,
            t,
            title: '100% Local & Private',
            subtitle: 'Zero cloud backup, zero network traffic, zero analytics trackers.',
          ),
          const SizedBox(height: NudgeSpacing.sm),
          _buildPrincipleCard(
            context,
            t,
            title: 'Pure Customization',
            subtitle: 'Full typography, color, and icon theme engine with live previews.',
          ),
        ],
      ),
    );
  }

  Widget _buildPrincipleCard(BuildContext context, NudgeThemeData t, {required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(NudgeSpacing.md),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: t.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: t.type.body.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(subtitle, style: t.type.caption.copyWith(color: t.secondaryText)),
        ],
      ),
    );
  }
}
