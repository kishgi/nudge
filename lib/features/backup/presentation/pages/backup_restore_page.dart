import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_service.dart';
import '../../../../core/theme/nudge_theme.dart';
import '../../../../core/theme/nudge_icons.dart';
import '../../../../core/theme/nudge_spacing.dart';
import '../../domain/services/backup_service.dart';
import '../../../launcher/presentation/providers/launcher_state.dart';

class BackupRestorePage extends ConsumerStatefulWidget {
  const BackupRestorePage({super.key});

  @override
  ConsumerState<BackupRestorePage> createState() => _BackupRestorePageState();
}

class _BackupRestorePageState extends ConsumerState<BackupRestorePage> {
  final TextEditingController _jsonController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  Future<void> _handleExport(BuildContext context) async {
    setState(() => _isProcessing = true);
    try {
      final db = ref.read(databaseServiceProvider);
      final backupService = BackupService(db);
      final jsonStr = await backupService.exportBackup();

      _jsonController.text = jsonStr;
      await Clipboard.setData(ClipboardData(text: jsonStr));

      if (mounted) {
        final t = context.nudgeTheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Backup copied to clipboard! You can save it to a local file.'),
            backgroundColor: t.semanticColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final t = context.nudgeTheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: ${e.toString()}'),
            backgroundColor: t.semanticColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _handleImport(BuildContext context) async {
    final t = context.nudgeTheme;
    final text = _jsonController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Paste or type valid backup JSON into the input box below first.'),
        ),
      );
      return;
    }

    final db = ref.read(databaseServiceProvider);
    final backupService = BackupService(db);

    // 1. Inspect first
    final inspection = backupService.inspectBackup(text);
    if (!inspection.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(inspection.message),
          backgroundColor: t.semanticColors.error,
        ),
      );
      return;
    }

    // 2. Prompt confirmation modal showing summary
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: t.surface,
        title: Text('Confirm Restore', style: t.type.headline.copyWith(color: t.primaryText)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restoring this backup will overwrite your current favorites, hidden apps, focus rules, and layout settings.',
              style: t.type.body.copyWith(color: t.primaryText),
            ),
            const SizedBox(height: NudgeSpacing.md),
            Text(
              'Contents: ${inspection.summary}',
              style: t.type.caption.copyWith(color: t.accent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: t.type.body.copyWith(color: t.secondaryText)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Overwrite & Restore', style: t.type.body.copyWith(color: t.semanticColors.error, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // 3. Perform import
    setState(() => _isProcessing = true);
    final result = await backupService.importBackup(text);
    if (mounted) {
      setState(() => _isProcessing = false);
      if (result.success) {
        await ref.read(launcherProvider.notifier).refreshApps();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.message), backgroundColor: t.semanticColors.success),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.message), backgroundColor: t.semanticColors.error),
        );
      }
    }
  }

  Future<void> _handleFactoryReset(BuildContext context) async {
    final t = context.nudgeTheme;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: t.surface,
        title: Text('Factory Reset Configuration?', style: t.type.headline.copyWith(color: t.primaryText)),
        content: Text(
          'This will reset all gestures, widgets, focus rules, themes, favorites, and launcher preferences to defaults. This action cannot be undone.',
          style: t.type.body.copyWith(color: t.primaryText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: t.type.body.copyWith(color: t.secondaryText)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Reset Everything', style: t.type.body.copyWith(color: t.semanticColors.error, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final db = ref.read(databaseServiceProvider);
    final backupService = BackupService(db);
    await backupService.factoryReset();
    await ref.read(launcherProvider.notifier).refreshApps();

    if (mounted) {
      final t = context.nudgeTheme;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Launcher settings reset to defaults.'),
          backgroundColor: t.semanticColors.warning,
        ),
      );
    }
  }

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
        title: Text('Backup & Restore', style: t.type.headline.copyWith(color: t.primaryText)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(NudgeSpacing.lg),
        children: [
          Text(
            'Export or import your complete Nudge layout, themes, focus rules, gestures, and settings as a local JSON payload.',
            style: t.type.body.copyWith(color: t.mutedText),
          ),
          const SizedBox(height: NudgeSpacing.xl),

          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: _isProcessing
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : Icon(t.icons.resolve(NudgeIconToken.share)),
                  label: const Text('Export JSON'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: t.accent,
                    foregroundColor: t.background,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isProcessing ? null : () => _handleExport(context),
                ),
              ),
              const SizedBox(width: NudgeSpacing.md),
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(t.icons.resolve(NudgeIconToken.add)),
                  label: const Text('Import JSON'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: t.primaryText,
                    side: BorderSide(color: t.divider),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isProcessing ? null : () => _handleImport(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: NudgeSpacing.xl),

          Text('Backup JSON Payload', style: t.type.body.copyWith(color: t.primaryText, fontWeight: FontWeight.bold)),
          const SizedBox(height: NudgeSpacing.xs),
          TextField(
            controller: _jsonController,
            maxLines: 10,
            style: t.type.caption.copyWith(fontFamily: 'monospace', color: t.primaryText),
            decoration: InputDecoration(
              hintText: 'Click "Export JSON" to copy backup here, or paste a backup payload to restore...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),

          const SizedBox(height: NudgeSpacing.xxl),
          Divider(color: t.divider),
          const SizedBox(height: NudgeSpacing.md),

          // Danger zone
          Text('Reset Launcher Settings', style: t.type.body.copyWith(color: t.semanticColors.error, fontWeight: FontWeight.bold)),
          const SizedBox(height: NudgeSpacing.xs),
          Text('Revert all launcher settings, rules, and themes to initial installation state.', style: t.type.caption.copyWith(color: t.mutedText)),
          const SizedBox(height: NudgeSpacing.md),

          OutlinedButton.icon(
            icon: Icon(t.icons.resolve(NudgeIconToken.delete), color: t.semanticColors.error),
            label: Text('Reset All Settings to Defaults', style: t.type.body.copyWith(color: t.semanticColors.error, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: t.semanticColors.error),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () => _handleFactoryReset(context),
          ),
        ],
      ),
    );
  }
}
