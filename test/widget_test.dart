// Widget smoke test — verifies that core theme widgets render without errors.
//
// NOTE: HomeScreen and NudgeApp both depend on Isar (DatabaseService), which
// requires a real filesystem and cannot be initialized in the flutter_test VM.
// Full launch integration tests live in integration_test/.
// This test verifies the NudgeTheme InheritedWidget and the design system work.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/theme/nudge_theme.dart';
import 'package:nudge/core/theme/theme_presets.dart';

void main() {
  testWidgets('NudgeTheme renders and exposes theme data', (WidgetTester tester) async {
    NudgeThemeData? capturedTheme;

    await tester.pumpWidget(
      NudgeTheme(
        data: NudgeThemePreset.pure.build(),
        child: Builder(
          builder: (context) {
            capturedTheme = NudgeTheme.of(context);
            return const MaterialApp(
              home: Scaffold(body: Text('Nudge')),
            );
          },
        ),
      ),
    );

    // Theme was injected correctly
    expect(capturedTheme, isNotNull);
    expect(capturedTheme!.colors, isNotNull);
    expect(capturedTheme!.type, isNotNull);

    // Text from the app renders
    expect(find.text('Nudge'), findsOneWidget);
  });
}
