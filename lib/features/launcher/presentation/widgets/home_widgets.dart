import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../domain/models/home_widget_config.dart';
import '../../../focus/presentation/providers/focus_provider.dart';

// ─── Battery info via platform channel ────────────────────────────────────────

final _batteryProvider = StreamProvider<int>((ref) {
  final controller = StreamController<int>();
  const channel = EventChannel('com.example.nudge/battery');
  try {
    channel.receiveBroadcastStream().listen(
          (v) => controller.add((v as int?) ?? -1),
          onError: (_) => controller.add(-1),
        );
  } catch (_) {
    controller.add(-1);
  }
  ref.onDispose(controller.close);
  return controller.stream;
});

// ─── Individual widget renders ────────────────────────────────────────────────

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final s = t.clockSettings;

    final String timeStr;
    if (s.clockFormat == '12') {
      final h = _now.hour == 0 ? 12 : (_now.hour > 12 ? _now.hour - 12 : _now.hour);
      final period = _now.hour >= 12 ? 'PM' : 'AM';
      final min = _now.minute.toString().padLeft(2, '0');
      final sec = s.showSeconds ? ':${_now.second.toString().padLeft(2, '0')}' : '';
      timeStr = '$h:$min$sec $period';
    } else {
      final h = _now.hour.toString().padLeft(2, '0');
      final min = _now.minute.toString().padLeft(2, '0');
      final sec = s.showSeconds ? ':${_now.second.toString().padLeft(2, '0')}' : '';
      timeStr = '$h:$min$sec';
    }

    return Text(
      timeStr,
      style: TextStyle(
        fontFamily: s.clockFontFamily ?? t.type.fontFamily,
        fontSize: t.type.display.fontSize! * s.clockSizeScale,
        fontWeight: s.clockFontWeight != null
            ? FontWeight.values.firstWhere((w) => w.value == s.clockFontWeight)
            : t.type.display.fontWeight,
        color: t.primaryText,
        letterSpacing: t.type.display.letterSpacing,
        height: t.type.display.height,
      ),
    );
  }
}

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _format(DateTime d, String pattern) {
    const wd = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const wdf = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const ms = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const mf = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    if (pattern == 'EEE, MMM d') return '${wd[d.weekday - 1]}, ${ms[d.month - 1]} ${d.day}';
    if (pattern == 'EEEE, MMMM d') return '${wdf[d.weekday - 1]}, ${mf[d.month - 1]} ${d.day}';
    if (pattern == 'dd/MM/yyyy') {
      return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
    }
    if (pattern == 'yyyy-MM-dd') {
      return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    }
    return '${wd[d.weekday - 1]}, ${ms[d.month - 1]} ${d.day}';
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    if (!t.clockSettings.showDate) return const SizedBox.shrink();
    return Text(
      _format(_now, t.clockSettings.dateFormat),
      style: t.type.body.copyWith(color: t.secondaryText, fontWeight: FontWeight.w400),
    );
  }
}

class BatteryWidget extends ConsumerWidget {
  const BatteryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.nudgeTheme;
    final batteryAsync = ref.watch(_batteryProvider);

    return batteryAsync.when(
      data: (level) {
        if (level < 0) return const SizedBox.shrink();
        final icon = level > 80
            ? Icons.battery_full
            : level > 50
                ? Icons.battery_5_bar
                : level > 20
                    ? Icons.battery_3_bar
                    : Icons.battery_alert;
        final color = level <= 20 ? t.semanticColors.error : t.secondaryText;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              '$level%',
              style: t.type.caption.copyWith(color: color),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class FocusTimerWidget extends ConsumerStatefulWidget {
  const FocusTimerWidget({super.key});

  @override
  ConsumerState<FocusTimerWidget> createState() => _FocusTimerWidgetState();
}

class _FocusTimerWidgetState extends ConsumerState<FocusTimerWidget> {
  late Timer _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.nudgeTheme;
    final focusState = ref.watch(focusProvider);
    final session = focusState.activeSession;

    if (session == null || !session.isActive) return const SizedBox.shrink();

    final elapsed = DateTime.now().difference(session.startTime);
    final remaining = Duration(minutes: session.targetDurationMinutes) - elapsed;
    if (remaining.isNegative) return const SizedBox.shrink();

    final minutes = remaining.inMinutes.toString().padLeft(2, '0');
    final seconds = (remaining.inSeconds % 60).toString().padLeft(2, '0');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_outlined, size: 14, color: t.accent),
        const SizedBox(width: 4),
        Text(
          '$minutes:$seconds',
          style: t.type.caption.copyWith(color: t.accent, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 4),
        Text(
          session.mode,
          style: t.type.caption.copyWith(color: t.mutedText),
        ),
      ],
    );
  }
}

// ─── Strip orchestrator ───────────────────────────────────────────────────────

/// Renders enabled home widgets in order, respecting alignment and spacing.
class HomeWidgetStrip extends StatelessWidget {
  const HomeWidgetStrip({
    super.key,
    required this.widgets,
    required this.spacing,
    required this.alignment,
  });

  final List<HomeWidgetConfig> widgets;
  final double spacing;
  final String alignment;

  CrossAxisAlignment get _cross {
    return switch (alignment) {
      'center' => CrossAxisAlignment.center,
      'right' => CrossAxisAlignment.end,
      _ => CrossAxisAlignment.start,
    };
  }

  @override
  Widget build(BuildContext context) {
    final visible = widgets.where((w) => w.visible).toList();
    if (visible.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: _cross,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < visible.length; i++) ...[
          _buildWidget(visible[i].type),
          if (i < visible.length - 1) SizedBox(height: spacing),
        ],
      ],
    );
  }

  Widget _buildWidget(HomeWidgetType type) {
    return switch (type) {
      HomeWidgetType.clock => const ClockWidget(),
      HomeWidgetType.date => const DateWidget(),
      HomeWidgetType.battery => const BatteryWidget(),
      HomeWidgetType.focusTimer => const FocusTimerWidget(),
    };
  }
}
