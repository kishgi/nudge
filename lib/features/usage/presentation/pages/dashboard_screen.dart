import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../launcher/presentation/providers/launcher_state.dart';
import '../providers/usage_provider.dart';
import '../widgets/permission_dialog.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _formatDuration(int ms) {
    if (ms <= 0) return '0m';
    final seconds = ms ~/ 1000;
    final minutes = seconds ~/ 60;
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours > 0) {
      return '${hours}h ${remainingMinutes}m';
    }
    return '${minutes}m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.nudgeTheme;
    final usageState = ref.watch(usageProvider);
    final usageNotifier = ref.read(usageProvider.notifier);
    final allApps = ref.watch(launcherProvider).allApps;

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
          'Wellbeing Dashboard',
          style: t.type.headline.copyWith(color: t.primaryText),
        ),
        actions: [
          IconButton(
            icon: Icon(t.icons.resolve(NudgeIconToken.success), color: t.secondaryText),
            onPressed: () => usageNotifier.refresh(),
          ),
        ],
      ),
      body: SafeArea(
        child: usageState.hasPermission
            ? _buildDashboardContent(context, ref, usageState, t, allApps)
            : _buildPermissionPrompt(context, ref, t),
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    WidgetRef ref,
    UsageState state,
    NudgeThemeData t,
    List<dynamic> allApps,
  ) {
    // Determine total launches today
    int totalLaunches = 0;
    for (final appStat in state.todayUsage) {
      totalLaunches += (appStat['launchCount'] as int? ?? 0);
    }

    // Determine focus score — heuristic: penalise heavy usage + frequent launches
    int focusScore = 75;
    if (state.totalScreenTimeMs > 0) {
      focusScore = 100 -
          (totalLaunches ~/ 2).clamp(0, 50) -
          (state.totalScreenTimeMs ~/ (60 * 60 * 1000)).clamp(0, 30);
      focusScore = focusScore.clamp(20, 100);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      children: [
        // Today Stats Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(NudgeRadius.small),
            color: t.accent.withValues(alpha: 0.03),
            border: Border.all(color: t.accent.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'TODAY OVERVIEW',
                style: t.type.caption.copyWith(
                  color: t.mutedText,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatTile(
                    label: 'Screen Time',
                    value: _formatDuration(state.totalScreenTimeMs),
                    t: t,
                  ),
                  _StatTile(
                    label: 'Launches',
                    value: '$totalLaunches',
                    t: t,
                  ),
                  _StatTile(
                    label: 'Focus Score',
                    value: '$focusScore%',
                    t: t,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Weekly Trend Section
        Text(
          'WEEKLY SCREEN TIME',
          style: t.type.caption.copyWith(
            color: t.mutedText,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        _buildWeeklyTrendChart(state, t),
        const SizedBox(height: 32),
        // Top Apps List
        Text(
          'TOP APPS TODAY',
          style: t.type.caption.copyWith(
            color: t.mutedText,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        if (state.todayUsage.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'No app usage recorded today.',
                style: t.type.body.copyWith(color: t.mutedText),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.todayUsage.length.clamp(0, 6),
            itemBuilder: (context, index) {
              final stat = state.todayUsage[index];
              final packageName = stat['packageName'] as String;
              final durationMs = stat['totalTimeInForeground'] as int? ?? 0;
              final launches = stat['launchCount'] as int? ?? 0;

              // Lookup installed app for a friendly name — fall back to last segment
              final matchedApp = allApps.cast<dynamic>().firstWhere(
                    (a) => a.packageName == packageName,
                    orElse: () => null,
                  );
              final appName = (matchedApp?.appName as String?) ??
                  packageName.split('.').last;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appName,
                            style: t.type.body.copyWith(
                              color: t.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '$launches launches',
                            style: t.type.caption.copyWith(color: t.mutedText),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _formatDuration(durationMs),
                      style: t.type.body.copyWith(
                        color: t.primaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildWeeklyTrendChart(UsageState state, NudgeThemeData t) {
    final maxDuration = state.weeklyUsage.isNotEmpty
        ? state.weeklyUsage
            .map((w) => w.totalScreenTimeMs)
            .reduce((a, b) => a > b ? a : b)
        : 1;

    final daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final now = DateTime.now();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(7, (index) {
        final targetDate = DateTime(now.year, now.month, now.day)
            .subtract(Duration(days: 6 - index));

        UsageSummary? daySummary;
        for (final w in state.weeklyUsage) {
          if (w.date.year == targetDate.year &&
              w.date.month == targetDate.month &&
              w.date.day == targetDate.day) {
            daySummary = w;
            break;
          }
        }

        final duration = daySummary?.totalScreenTimeMs ?? 0;
        final ratio =
            maxDuration > 0 ? (duration / maxDuration).clamp(0.0, 1.0) : 0.0;
        final barHeight = 80.0 * ratio;

        return Expanded(
          child: Column(
            children: [
              Container(
                height: 80,
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: barHeight > 4 ? barHeight : 4,
                  width: 12,
                  decoration: BoxDecoration(
                    color: index == 6
                        ? t.accent
                        : t.secondaryText.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                daysOfWeek[(targetDate.weekday - 1) % 7],
                style: t.type.caption.copyWith(
                  color: index == 6 ? t.primaryText : t.mutedText,
                  fontWeight:
                      index == 6 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPermissionPrompt(
      BuildContext context, WidgetRef ref, NudgeThemeData t) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            t.icons.resolve(NudgeIconToken.warning),
            size: 48,
            color: t.accent,
          ),
          const SizedBox(height: 24),
          Text(
            'Usage Statistics Access Needed',
            style: t.type.title
                .copyWith(color: t.primaryText, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Nudge requires Usage Statistics Access to track daily screen time, launches, '
            'and show digital wellbeing insights. Your data is processed entirely locally.',
            style: t.type.body.copyWith(color: t.secondaryText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: t.accent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(NudgeRadius.small),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const PermissionDialog(),
              );
            },
            child: Text(
              'Grant Access',
              style: t.type.body
                  .copyWith(color: t.background, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.t,
  });

  final String label;
  final String value;
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: t.type.title
              .copyWith(color: t.primaryText, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: t.type.caption.copyWith(color: t.mutedText),
        ),
      ],
    );
  }
}
