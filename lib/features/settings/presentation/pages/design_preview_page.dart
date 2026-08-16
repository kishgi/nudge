import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/nudge_icons.dart';
import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/theme_presets.dart';
import '../../../../core/theme/theme_provider.dart';

/// Design System Preview Screen
///
/// Temporary screen that validates the full Nudge design token system before
/// any feature development begins. Remove or gate this screen in later phases.
class DesignPreviewPage extends ConsumerStatefulWidget {
  const DesignPreviewPage({super.key});

  @override
  ConsumerState<DesignPreviewPage> createState() => _DesignPreviewPageState();
}

class _DesignPreviewPageState extends ConsumerState<DesignPreviewPage> {
  bool _toggleValue = true;
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;

    return Scaffold(
      backgroundColor: t.background,
      body: CustomScrollView(
        slivers: [
          // ─── App Bar ─────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: t.background,
            title: Text(
              'Design System',
              style: t.type.title.copyWith(color: t.primaryText),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(height: 1, color: t.divider),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: NudgeSpacing.pageHorizontal,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: NudgeSpacing.xl),

                // ─── Theme Switcher ─────────────────────────────────────────
                _SectionHeader(label: 'Theme Preset', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _ThemePresetSwitcher(t: t),

                _Divider(t: t),

                // ─── Color Swatches ────────────────────────────────────────
                _SectionHeader(label: 'Color Tokens', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _ColorSwatches(t: t),

                _Divider(t: t),

                // ─── Typography ────────────────────────────────────────────
                _SectionHeader(label: 'Typography Scale', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _TypographyScale(t: t),

                _Divider(t: t),

                // ─── Spacing ───────────────────────────────────────────────
                _SectionHeader(label: 'Spacing Tokens', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _SpacingTokens(t: t),

                _Divider(t: t),

                // ─── Radius ────────────────────────────────────────────────
                _SectionHeader(label: 'Radius Tokens', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _RadiusTokens(t: t),

                _Divider(t: t),

                // ─── Buttons ───────────────────────────────────────────────
                _SectionHeader(label: 'Buttons', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _ButtonShowcase(t: t),

                _Divider(t: t),

                // ─── Toggle ────────────────────────────────────────────────
                _SectionHeader(label: 'Toggle', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _ToggleShowcase(
                  t: t,
                  value: _toggleValue,
                  onChanged: (v) => setState(() => _toggleValue = v),
                ),

                _Divider(t: t),

                // ─── Input ─────────────────────────────────────────────────
                _SectionHeader(label: 'Input Field', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _InputShowcase(
                  t: t,
                  value: _inputValue,
                  onChanged: (v) => setState(() => _inputValue = v),
                ),

                _Divider(t: t),

                // ─── Cards ─────────────────────────────────────────────────
                _SectionHeader(label: 'Cards & Surfaces', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _CardShowcase(t: t),

                _Divider(t: t),

                // ─── Icons ─────────────────────────────────────────────────
                _SectionHeader(label: 'Icon Tokens', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _IconShowcase(t: t),

                _Divider(t: t),

                // ─── Status States ─────────────────────────────────────────
                _SectionHeader(label: 'Status States', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _StatusShowcase(t: t),

                _Divider(t: t),

                // ─── Selected / Focus States ───────────────────────────────
                _SectionHeader(label: 'Selection & Focus States', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _SelectionStates(t: t),

                _Divider(t: t),

                // ─── Motion Tokens ─────────────────────────────────────────
                _SectionHeader(label: 'Motion Mode', t: t),
                const SizedBox(height: NudgeSpacing.md),
                _MotionInfo(t: t),

                const SizedBox(height: NudgeSpacing.huge),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section primitives
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.t});
  final String label;
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: t.type.caption.copyWith(
        color: t.mutedText,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: NudgeSpacing.xl),
      child: Divider(height: 1, color: t.divider),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Theme Preset Switcher
// ─────────────────────────────────────────────────────────────────────────────

class _ThemePresetSwitcher extends ConsumerWidget {
  const _ThemePresetSwitcher({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePreset = ref.watch(nudgeThemePresetProvider);

    return Wrap(
      spacing: NudgeSpacing.sm,
      runSpacing: NudgeSpacing.sm,
      children: NudgeThemePreset.values.map((preset) {
        final isActive = preset == activePreset;
        return GestureDetector(
          onTap: () =>
              ref.read(nudgeThemeProvider.notifier).setPreset(preset),
          child: AnimatedContainer(
            duration: t.motion.normal,
            curve: t.motion.curve,
            padding: const EdgeInsets.symmetric(
              horizontal: NudgeSpacing.lg,
              vertical: NudgeSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isActive ? t.accent : Colors.transparent,
              borderRadius: NudgeRadius.smallAll,
              border: Border.all(
                color: isActive ? t.accent : t.divider,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isActive) ...[
                  Icon(Icons.check, size: 14, color: Colors.white),
                  const SizedBox(width: NudgeSpacing.xs),
                ],
                Text(
                  preset.label,
                  style: t.type.label.copyWith(
                    color: isActive ? Colors.white : t.secondaryText,
                    fontWeight: isActive
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Color Swatches
// ─────────────────────────────────────────────────────────────────────────────

class _ColorSwatches extends StatelessWidget {
  const _ColorSwatches({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    final swatches = [
      ('background', t.background, t.primaryText),
      ('surface', t.surface, t.primaryText),
      ('primaryText', t.primaryText, t.background),
      ('secondaryText', t.secondaryText, t.background),
      ('mutedText', t.mutedText, t.background),
      ('accent', t.accent, const Color(0xFFFFFFFF)),
      ('accentLight', t.accentLight, const Color(0xFFFFFFFF)),
      ('accentDark', t.accentDark, const Color(0xFFFFFFFF)),
      ('divider', t.divider, t.primaryText),
    ];

    return Wrap(
      spacing: NudgeSpacing.sm,
      runSpacing: NudgeSpacing.sm,
      children: swatches.map((s) {
        final (name, bg, fg) = s;
        return Container(
          width: 140,
          padding: const EdgeInsets.all(NudgeSpacing.md),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: NudgeRadius.smallAll,
            border: Border.all(color: t.divider, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: NudgeSpacing.xl),
              Text(
                name,
                style: t.type.caption.copyWith(color: fg),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Typography Scale
// ─────────────────────────────────────────────────────────────────────────────

class _TypographyScale extends StatelessWidget {
  const _TypographyScale({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    final roles = [
      ('Display', t.type.display),
      ('Headline', t.type.headline),
      ('Title', t.type.title),
      ('Body', t.type.body),
      ('Label', t.type.label),
      ('Caption', t.type.caption),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: roles.map((r) {
        final (name, style) = r;
        return Padding(
          padding: const EdgeInsets.only(bottom: NudgeSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              SizedBox(
                width: 72,
                child: Text(
                  name,
                  style: t.type.caption.copyWith(color: t.mutedText),
                ),
              ),
              Expanded(
                child: Text(
                  'The quick brown fox',
                  style: style.copyWith(color: t.primaryText),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: NudgeSpacing.md),
              Text(
                '${style.fontSize?.toStringAsFixed(0)}px',
                style: t.type.caption.copyWith(color: t.mutedText),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Spacing Tokens
// ─────────────────────────────────────────────────────────────────────────────

class _SpacingTokens extends StatelessWidget {
  const _SpacingTokens({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    final tokens = [
      ('xs', NudgeSpacing.xs),
      ('sm', NudgeSpacing.sm),
      ('md', NudgeSpacing.md),
      ('lg', NudgeSpacing.lg),
      ('xl', NudgeSpacing.xl),
      ('xxl', NudgeSpacing.xxl),
      ('huge', NudgeSpacing.huge),
    ];

    return Column(
      children: tokens.map((tok) {
        final (name, size) = tok;
        return Padding(
          padding: const EdgeInsets.only(bottom: NudgeSpacing.sm),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  name,
                  style: t.type.caption.copyWith(color: t.mutedText),
                ),
              ),
              Container(
                width: size,
                height: 20,
                color: t.accent.withValues(alpha: 0.6),
              ),
              const SizedBox(width: NudgeSpacing.sm),
              Text(
                '${size.toStringAsFixed(0)}dp',
                style: t.type.caption.copyWith(color: t.secondaryText),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Radius Tokens
// ─────────────────────────────────────────────────────────────────────────────

class _RadiusTokens extends StatelessWidget {
  const _RadiusTokens({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    final tokens = [
      ('xs (4)', NudgeRadius.xs),
      ('small (8)', NudgeRadius.small),
      ('medium (12)', NudgeRadius.medium),
      ('large (16)', NudgeRadius.large),
      ('xl (24)', NudgeRadius.xl),
    ];

    return Wrap(
      spacing: NudgeSpacing.md,
      runSpacing: NudgeSpacing.md,
      children: tokens.map((tok) {
        final (name, radius) = tok;
        return Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: t.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: t.accent, width: 1.5),
              ),
            ),
            const SizedBox(height: NudgeSpacing.xs),
            Text(
              name,
              style: t.type.caption.copyWith(color: t.mutedText),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Buttons
// ─────────────────────────────────────────────────────────────────────────────

class _ButtonShowcase extends StatelessWidget {
  const _ButtonShowcase({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: NudgeSpacing.sm,
      runSpacing: NudgeSpacing.sm,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Primary'),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Secondary'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Ghost'),
        ),
        // Destructive
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: t.semanticColors.error,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: NudgeSpacing.xl,
              vertical: NudgeSpacing.md,
            ),
            shape: RoundedRectangleBorder(borderRadius: NudgeRadius.smallAll),
          ),
          child: const Text('Destructive'),
        ),
        // Disabled
        ElevatedButton(
          onPressed: null,
          child: const Text('Disabled'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Toggle
// ─────────────────────────────────────────────────────────────────────────────

class _ToggleShowcase extends StatelessWidget {
  const _ToggleShowcase({
    required this.t,
    required this.value,
    required this.onChanged,
  });
  final NudgeThemeData t;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(value: value, onChanged: onChanged),
        const SizedBox(width: NudgeSpacing.md),
        Text(
          value ? 'Enabled' : 'Disabled',
          style: t.type.body.copyWith(color: t.primaryText),
        ),
        const SizedBox(width: NudgeSpacing.xl),
        Switch(value: !value, onChanged: (v) => onChanged(!v)),
        const SizedBox(width: NudgeSpacing.md),
        Text(
          !value ? 'Enabled' : 'Disabled',
          style: t.type.body.copyWith(color: t.primaryText),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Input
// ─────────────────────────────────────────────────────────────────────────────

class _InputShowcase extends StatelessWidget {
  const _InputShowcase({
    required this.t,
    required this.value,
    required this.onChanged,
  });
  final NudgeThemeData t;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: onChanged,
          style: t.type.body.copyWith(color: t.primaryText),
          decoration: const InputDecoration(
            hintText: 'Search apps…',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: NudgeSpacing.md),
        TextField(
          style: t.type.body.copyWith(color: t.primaryText),
          decoration: InputDecoration(
            hintText: 'Error state',
            errorText: 'This field is required',
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cards
// ─────────────────────────────────────────────────────────────────────────────

class _CardShowcase extends StatelessWidget {
  const _CardShowcase({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Standard card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(NudgeSpacing.lg),
          decoration: BoxDecoration(
            color: t.surface,
            borderRadius: NudgeRadius.mediumAll,
            border: Border.all(color: t.divider, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Surface Card',
                  style: t.type.title.copyWith(color: t.primaryText)),
              const SizedBox(height: NudgeSpacing.xs),
              Text(
                'This is the standard surface token applied to a card component. '
                'Minimal elevation, restrained border.',
                style: t.type.body.copyWith(color: t.secondaryText),
              ),
            ],
          ),
        ),
        const SizedBox(height: NudgeSpacing.md),
        // Accent card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(NudgeSpacing.lg),
          decoration: BoxDecoration(
            color: t.accent.withValues(alpha: 0.08),
            borderRadius: NudgeRadius.mediumAll,
            border: Border.all(
                color: t.accent.withValues(alpha: 0.3), width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: t.accent, size: 20),
              const SizedBox(width: NudgeSpacing.md),
              Expanded(
                child: Text(
                  'Accent-tinted card. Uses accent with low opacity fill.',
                  style: t.type.body.copyWith(color: t.primaryText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Icons
// ─────────────────────────────────────────────────────────────────────────────

class _IconShowcase extends StatelessWidget {
  const _IconShowcase({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    final tokens = [
      NudgeIconToken.home,
      NudgeIconToken.search,
      NudgeIconToken.settings,
      NudgeIconToken.focus,
      NudgeIconToken.usage,
      NudgeIconToken.apps,
      NudgeIconToken.close,
      NudgeIconToken.add,
      NudgeIconToken.check,
      NudgeIconToken.arrowBack,
      NudgeIconToken.moon,
      NudgeIconToken.sun,
      NudgeIconToken.palette,
      NudgeIconToken.lock,
      NudgeIconToken.notification,
    ];

    return Wrap(
      spacing: NudgeSpacing.md,
      runSpacing: NudgeSpacing.md,
      children: tokens.map((tok) {
        return Tooltip(
          message: tok.name,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: t.surface,
              borderRadius: NudgeRadius.smallAll,
              border: Border.all(color: t.divider, width: 1),
            ),
            child: Icon(
              t.icons.resolve(tok),
              color: t.secondaryText,
              size: 20,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status States
// ─────────────────────────────────────────────────────────────────────────────

class _StatusShowcase extends StatelessWidget {
  const _StatusShowcase({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    final sc = t.semanticColors;
    final statuses = [
      ('Success', sc.success, sc.successSubtle, Icons.check_circle_outline,
          'Operation completed'),
      ('Warning', sc.warning, sc.warningSubtle, Icons.warning_amber_outlined,
          'Proceed with caution'),
      ('Error', sc.error, sc.errorSubtle, Icons.error_outline,
          'Something went wrong'),
      ('Info', sc.info, sc.infoSubtle, Icons.info_outline,
          'For your information'),
    ];

    return Column(
      children: statuses.map((s) {
        final (label, color, bg, icon, desc) = s;
        return Padding(
          padding: const EdgeInsets.only(bottom: NudgeSpacing.sm),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: NudgeSpacing.lg,
              vertical: NudgeSpacing.md,
            ),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: NudgeRadius.smallAll,
              border: Border.all(
                  color: color.withValues(alpha: 0.3), width: 1),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: NudgeSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: t.type.label.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      desc,
                      style: t.type.caption.copyWith(color: t.secondaryText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Selection States
// ─────────────────────────────────────────────────────────────────────────────

class _SelectionStates extends StatefulWidget {
  const _SelectionStates({required this.t});
  final NudgeThemeData t;

  @override
  State<_SelectionStates> createState() => _SelectionStatesState();
}

class _SelectionStatesState extends State<_SelectionStates> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    final items = ['Unselected', 'Selected', 'Focused', 'Blocked'];

    return Column(
      children: List.generate(items.length, (i) {
        final isSelected = _selected == i;
        final isBlocked = i == 3;
        final isFocused = i == 2;

        Color borderColor;
        Color bgColor;
        Color textColor;
        Widget? trailingIcon;
        String? semanticLabel;

        if (isBlocked) {
          borderColor = t.semanticColors.error.withValues(alpha: 0.4);
          bgColor = t.semanticColors.errorSubtle;
          textColor = t.semanticColors.error;
          trailingIcon =
              Icon(Icons.block, size: 16, color: t.semanticColors.error);
          semanticLabel = 'Blocked';
        } else if (isSelected) {
          borderColor = t.accent;
          bgColor = t.accent.withValues(alpha: 0.08);
          textColor = t.accent;
          trailingIcon =
              Icon(Icons.check, size: 16, color: t.accent);
          semanticLabel = 'Selected';
        } else if (isFocused) {
          borderColor = t.accent.withValues(alpha: 0.5);
          bgColor = Colors.transparent;
          textColor = t.primaryText;
          trailingIcon = null;
          semanticLabel = 'Focused';
        } else {
          borderColor = t.divider;
          bgColor = Colors.transparent;
          textColor = t.secondaryText;
          trailingIcon = null;
          semanticLabel = null;
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: NudgeSpacing.sm),
          child: GestureDetector(
            onTap: isBlocked ? null : () => setState(() => _selected = i),
            child: AnimatedContainer(
              duration: t.motion.normal,
              curve: t.motion.curve,
              padding: const EdgeInsets.symmetric(
                horizontal: NudgeSpacing.lg,
                vertical: NudgeSpacing.md,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: NudgeRadius.smallAll,
                border: Border.all(color: borderColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[i],
                          style: t.type.label.copyWith(color: textColor),
                        ),
                        if (semanticLabel != null)
                          Text(
                            semanticLabel,
                            style: t.type.caption
                                .copyWith(color: textColor.withValues(alpha: 0.7)),
                          ),
                      ],
                    ),
                  ),
                  ?trailingIcon,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Motion Info
// ─────────────────────────────────────────────────────────────────────────────

class _MotionInfo extends StatelessWidget {
  const _MotionInfo({required this.t});
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    final m = t.motion;
    final rows = [
      ('Mode', m.mode.label),
      ('Fast', '${m.fast.inMilliseconds}ms'),
      ('Normal', '${m.normal.inMilliseconds}ms'),
      ('Slow', '${m.slow.inMilliseconds}ms'),
    ];

    return Container(
      padding: const EdgeInsets.all(NudgeSpacing.lg),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: NudgeRadius.mediumAll,
        border: Border.all(color: t.divider, width: 1),
      ),
      child: Column(
        children: rows.map((r) {
          final (label, value) = r;
          return Padding(
            padding: const EdgeInsets.only(bottom: NudgeSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label,
                    style: t.type.label.copyWith(color: t.secondaryText)),
                Text(value,
                    style: t.type.label.copyWith(
                      color: t.primaryText,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
