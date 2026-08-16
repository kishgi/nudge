import 'package:flutter/material.dart';

import '../../../../core/theme/nudge_theme.dart';
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
          icon: Icon(Icons.arrow_back, color: t.primaryText),
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
                  child: Icon(Icons.blur_on, color: t.accent, size: 40),
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
                  'Version 1.0.0 (Phase 5 Release)',
                  style: t.type.caption.copyWith(color: t.mutedText),
                ),
              ],
            ),
          ),

          const SizedBox(height: NudgeSpacing.xxl),

          // Core Principles
          _buildSection(
            context,
            title: 'Our Core Principles',
            content: '1. Absolute Privacy: 100% offline, zero network requests, local storage only.\n'
                '2. Friction by Design: Helps you break compulsive phone habits using delay screens and intelligent focus rules.\n'
                '3. Performance & Craft: Lightning fast startup, minimal memory footprint, and typography-first aesthetic.',
          ),

          const SizedBox(height: NudgeSpacing.lg),

          // Technical Details
          _buildSection(
            context,
            title: 'Technical Stack',
            content: '• Framework: Flutter (Dart 3+)\n'
                '• Local Database: Isar Community Edition\n'
                '• Architecture: Feature-first Riverpod State Management\n'
                '• Design System: Custom Nudge Typography & Color Tokens',
          ),

          const SizedBox(height: NudgeSpacing.lg),

          // Open Source
          _buildSection(
            context,
            title: 'Open Source Notices',
            content: 'Nudge uses open-source libraries under MIT and Apache-2.0 licenses, including Flutter, Riverpod, Isar, and Google Fonts.',
          ),

          const SizedBox(height: NudgeSpacing.xxl),
          Center(
            child: Text(
              'Designed & built for intentional smartphone usage.',
              style: t.type.caption.copyWith(color: t.mutedText, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required String content}) {
    final t = context.nudgeTheme;
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
          const SizedBox(height: NudgeSpacing.xs),
          Text(content, style: t.type.caption.copyWith(color: t.secondaryText, height: 1.4)),
        ],
      ),
    );
  }
}
