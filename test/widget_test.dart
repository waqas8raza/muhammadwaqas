import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Smoke test - app loads', (WidgetTester tester) async {
    // Build our app and trigger a frame under ProviderScope.
    await tester.pumpWidget(
      const ProviderScope(
        child: PortfolioApp(),
      ),
    );

    // Verify that the title/brand element exists in the widget tree.
    expect(find.textContaining('Waqas'), findsWidgets);
  });
}
