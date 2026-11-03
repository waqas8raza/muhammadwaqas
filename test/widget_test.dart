import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Smoke test - app loads on default viewport', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PortfolioApp(),
      ),
    );
    expect(find.textContaining('Waqas'), findsWidgets);
  });

  testWidgets('Responsive test - mobile viewport (375x667)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 667);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Waqas'), findsWidgets);
  });

  testWidgets('Responsive test - tablet viewport (768x1024)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Waqas'), findsWidgets);
  });

  testWidgets('Responsive test - desktop viewport (1280x800)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Waqas'), findsWidgets);
  });
}
