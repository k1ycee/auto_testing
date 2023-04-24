import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:automated_testing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Test Play, Pause and Stop buttons are working as expected',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      // Finds the floating action button to tap on.
      final Finder play = find.byTooltip('Play');
      final Finder pause = find.byTooltip('Pause');
      await tester.tap(play);
      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(pause);
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Test Play, Pause and Stop buttons are working as expected',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      // Finds the floating action button to tap on.
      final Finder play = find.byTooltip('Play');
      final Finder pause = find.byTooltip('Pause');
      final Finder stop = find.byTooltip('Stop');

      await tester.tap(play);
      await Future.delayed(const Duration(seconds: 40));
      await tester.tap(pause);

      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('39'), findsOneWidget);
    });
  });
}
