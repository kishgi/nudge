import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_radius.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../launcher/presentation/providers/launcher_state.dart';
import '../providers/focus_provider.dart';
import '../../domain/models/focus_models.dart';

class FocusSettingsPage extends ConsumerWidget {
  const FocusSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.nudgeTheme;
    final focusState = ref.watch(focusProvider);
    final focusNotifier = ref.read(focusProvider.notifier);
    final apps = ref.watch(launcherProvider).allApps.where((a) => !a.isHidden).toList();

    apps.sort((a, b) => a.appName.toLowerCase().compareTo(b.appName.toLowerCase()));

    final activeSession = focusState.activeSession;

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
          'Focus & Block rules',
          style: t.type.headline.copyWith(color: t.primaryText),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const SizedBox(height: 16),
            // Focus Session Section
            Text(
              'FOCUS SESSION',
              style: t.type.caption.copyWith(color: t.mutedText, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 12),
            if (activeSession != null && activeSession.isActive) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: t.accent.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(NudgeRadius.small),
                  color: t.accent.withValues(alpha: 0.04),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Active Session: ${activeSession.mode}',
                      style: t.type.body.copyWith(color: t.primaryText, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Started at ${activeSession.startTime.hour.toString().padLeft(2, '0')}:${activeSession.startTime.minute.toString().padLeft(2, '0')}. Blocks all selected apps.',
                      style: t.type.caption.copyWith(color: t.secondaryText),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: t.semanticColors.error.withValues(alpha: 0.1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(NudgeRadius.small),
                        ),
                      ),
                      onPressed: () {
                        focusNotifier.cancelFocusSession();
                      },
                      child: Text(
                        'End Session',
                        style: t.type.body.copyWith(color: t.semanticColors.error, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _SessionButton(mode: 'Work', duration: 25, notifier: focusNotifier, t: t),
                  _SessionButton(mode: 'Study', duration: 45, notifier: focusNotifier, t: t),
                  _SessionButton(mode: 'Sleep', duration: 480, notifier: focusNotifier, t: t),
                ],
              ),
            ],
            const SizedBox(height: 32),
            // Block Rules Section
            Text(
              'APP BLOCK RULES',
              style: t.type.caption.copyWith(color: t.mutedText, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                final rule = focusState.rules.firstWhere(
                  (r) => r.packageName == app.packageName,
                  orElse: () => FocusRule()..packageName = app.packageName,
                );

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    app.appName,
                    style: t.type.body.copyWith(color: t.primaryText, fontWeight: rule.isBlocked ? FontWeight.w600 : FontWeight.w400),
                  ),
                  subtitle: Text(
                    rule.isBlocked
                        ? (rule.delaySeconds > 0 ? '${rule.delaySeconds}s delay active' : 'Blocked')
                        : 'Allowed',
                    style: t.type.caption.copyWith(color: rule.isBlocked ? t.accent : t.mutedText),
                  ),
                  trailing: Switch(
                    value: rule.isBlocked,
                    activeThumbColor: t.accent,
                    onChanged: (value) {
                      focusNotifier.toggleRule(app.packageName, value);
                    },
                  ),
                  onTap: () {
                    // Open dialog or navigation to customize this rule
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: t.background,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (_) => _RuleConfigBottomSheet(app: app, rule: rule, notifier: focusNotifier, t: t),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionButton extends StatelessWidget {
  const _SessionButton({
    required this.mode,
    required this.duration,
    required this.notifier,
    required this.t,
  });

  final String mode;
  final int duration;
  final FocusNotifier notifier;
  final NudgeThemeData t;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: t.accent.withValues(alpha: 0.08),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NudgeRadius.small),
          side: BorderSide(color: t.accent.withValues(alpha: 0.15)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onPressed: () {
        notifier.startFocusSession(mode, duration);
      },
      child: Text(
        'Start $mode ($duration min)',
        style: t.type.caption.copyWith(color: t.accent, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _RuleConfigBottomSheet extends StatefulWidget {
  const _RuleConfigBottomSheet({
    required this.app,
    required this.rule,
    required this.notifier,
    required this.t,
  });

  final dynamic app;
  final FocusRule rule;
  final FocusNotifier notifier;
  final NudgeThemeData t;

  @override
  State<_RuleConfigBottomSheet> createState() => _RuleConfigBottomSheetState();
}

class _RuleConfigBottomSheetState extends State<_RuleConfigBottomSheet> {
  late int _delaySeconds;
  late TextEditingController _messageController;
  late bool _scheduleEnabled;
  late int _startH;
  late int _startM;
  late int _endH;
  late int _endM;

  @override
  void initState() {
    super.initState();
    _delaySeconds = widget.rule.delaySeconds;
    _messageController = TextEditingController(text: widget.rule.customMessage);
    _scheduleEnabled = widget.rule.scheduleEnabled;
    _startH = widget.rule.startHour;
    _startM = widget.rule.startMinute;
    _endH = widget.rule.endHour;
    _endM = widget.rule.endMinute;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            'Configure Rule: ${widget.app.appName}',
            style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            'Opening Delay (Seconds)',
            style: t.type.caption.copyWith(color: t.mutedText),
          ),
          Slider(
            value: _delaySeconds.toDouble(),
            min: 0,
            max: 60,
            divisions: 12,
            activeColor: t.accent,
            inactiveColor: t.divider,
            label: '${_delaySeconds}s',
            onChanged: (val) {
              setState(() {
                _delaySeconds = val.toInt();
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Custom Block Message',
            style: t.type.caption.copyWith(color: t.mutedText),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _messageController,
            style: t.type.body.copyWith(color: t.primaryText),
            decoration: InputDecoration(
              hintText: 'e.g. Do you really need social media right now?',
              hintStyle: t.type.body.copyWith(color: t.mutedText),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: t.accent)),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Enable Schedule Blocker',
                style: t.type.body.copyWith(color: t.primaryText),
              ),
              Switch(
                value: _scheduleEnabled,
                activeThumbColor: t.accent,
                onChanged: (val) {
                  setState(() {
                    _scheduleEnabled = val;
                  });
                },
              ),
            ],
          ),
          if (_scheduleEnabled) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: _startH, minute: _startM),
                      );
                      if (time != null) {
                        setState(() {
                          _startH = time.hour;
                          _startM = time.minute;
                        });
                      }
                    },
                    child: Text('Start: ${_startH.toString().padLeft(2, '0')}:${_startM.toString().padLeft(2, '0')}'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: _endH, minute: _endM),
                      );
                      if (time != null) {
                        setState(() {
                          _endH = time.hour;
                          _endM = time.minute;
                        });
                      }
                    },
                    child: Text('End: ${_endH.toString().padLeft(2, '0')}:${_endM.toString().padLeft(2, '0')}'),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: t.accent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              final nav = Navigator.of(context);
              await widget.notifier.setRuleDelay(widget.rule.packageName, _delaySeconds);
              await widget.notifier.updateRuleMessage(widget.rule.packageName, _messageController.text);
              await widget.notifier.setRuleSchedule(
                widget.rule.packageName,
                enabled: _scheduleEnabled,
                days: [1, 2, 3, 4, 5, 6, 7], // Default to all days
                startH: _startH,
                startM: _startM,
                endH: _endH,
                endM: _endM,
              );
              nav.pop();
            },
            child: Text(
              'Save Configuration',
              style: t.type.body.copyWith(color: t.background, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
