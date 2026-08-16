import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../../core/theme/nudge_radius.dart';
import '../../../launcher/presentation/providers/launcher_state.dart';
import '../providers/focus_provider.dart';
import '../../domain/models/focus_models.dart';

class FocusBlockScreen extends ConsumerStatefulWidget {
  const FocusBlockScreen({
    super.key,
    required this.packageName,
    required this.rule,
  });

  final String packageName;
  final FocusRule rule;

  @override
  ConsumerState<FocusBlockScreen> createState() => _FocusBlockScreenState();
}

class _FocusBlockScreenState extends ConsumerState<FocusBlockScreen> {
  int _secondsLeft = 0;
  Timer? _timer;
  bool _canContinue = false;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.rule.delaySeconds;
    if (_secondsLeft > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) return;
        setState(() {
          if (_secondsLeft > 1) {
            _secondsLeft--;
          } else {
            _secondsLeft = 0;
            _canContinue = true;
            _timer?.cancel();
          }
        });
      });
    } else {
      _canContinue = true;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;

    // Look up the app name from launcher state; fall back to last package segment.
    final allApps = ref.watch(launcherProvider).allApps;
    final matched = allApps.where((a) => a.packageName == widget.packageName);
    final appName =
        matched.isNotEmpty ? matched.first.appName : widget.packageName.split('.').last;

    final message = widget.rule.customMessage ??
        'Are you sure you need to open this right now?';

    return Scaffold(
      backgroundColor: t.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                t.icons.resolve(NudgeIconToken.focus),
                size: 64,
                color: t.accent,
              ),
              const SizedBox(height: 32),
              Text(
                'Nudge',
                style: t.type.headline.copyWith(
                  color: t.primaryText,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: t.type.title.copyWith(color: t.primaryText),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Focus is active on $appName',
                style: t.type.caption.copyWith(color: t.secondaryText),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (_secondsLeft > 0) ...[
                Text(
                  'Waiting for $_secondsLeft seconds...',
                  style: t.type.body.copyWith(
                    color: t.accent,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: t.secondaryText.withValues(alpha: 0.3)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(NudgeRadius.small),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: t.type.body.copyWith(color: t.secondaryText),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _canContinue
                            ? t.accent
                            : t.mutedText.withValues(alpha: 0.1),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(NudgeRadius.small),
                        ),
                      ),
                      onPressed: _canContinue ? _launchAndPop : null,
                      child: Text(
                        'Continue',
                        style: t.type.body.copyWith(
                          color: _canContinue ? t.background : t.mutedText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: _disableRuleAndLaunch,
                child: Text(
                  'Temporarily disable rule',
                  style: t.type.caption.copyWith(
                    color: t.secondaryText,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Launches the app then pops the block screen (captures navigator before await).
  Future<void> _launchAndPop() async {
    final navigator = Navigator.of(context);
    await ref.read(launcherProvider.notifier).launchApp(widget.packageName);
    navigator.pop();
  }

  /// Disables the focus rule, launches, then pops — user always has a way out.
  Future<void> _disableRuleAndLaunch() async {
    await ref.read(focusProvider.notifier).toggleRule(widget.packageName, false);
    if (!mounted) return;
    final navigator = Navigator.of(context);
    await ref.read(launcherProvider.notifier).launchApp(widget.packageName);
    navigator.pop();
  }
}
