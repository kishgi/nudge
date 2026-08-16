import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_radius.dart';
import '../providers/usage_provider.dart';

class PermissionDialog extends ConsumerWidget {
  const PermissionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.nudgeTheme;

    return AlertDialog(
      backgroundColor: t.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(NudgeRadius.small),
      ),
      title: Text(
        'Usage Access Permission',
        style: t.type.title.copyWith(color: t.primaryText, fontWeight: FontWeight.bold),
      ),
      content: Text(
        'To proceed, Android settings will open. Please locate "Nudge" in the list and enable "Permit usage access".\n\nThis is only used locally to calculate your screen time.',
        style: t.type.body.copyWith(color: t.secondaryText),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: t.type.body.copyWith(color: t.secondaryText),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: t.accent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(NudgeRadius.small),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            ref.read(usageProvider.notifier).requestUsagePermission();
          },
          child: Text(
            'Open Settings',
            style: t.type.body.copyWith(color: t.background, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
