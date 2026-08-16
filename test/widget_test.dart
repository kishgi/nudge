import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nudge/main.dart';
import 'package:nudge/features/settings/presentation/pages/design_preview_page.dart';

void main() {
  testWidgets('Design system preview renders smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: NudgeApp()));

    // Verify that the title is rendered.
    expect(find.text('Design System'), findsOneWidget);
    
    // Verify that the preview screen is present.
    expect(find.byType(DesignPreviewPage), findsOneWidget);
  });
}
