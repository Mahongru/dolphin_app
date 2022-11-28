import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dolphin_app/dolphin/dolphin.dart';

void main() {
  testWidgets('When play button is pressed Then dolphins get played',
      (WidgetTester tester) async {
    final playButton = find.byKey(const ValueKey('playButton'));

    await tester.pumpWidget(MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => DolphinService())],
      child: const DolphinPage(),
    ));

    // Test action
    await tester.tap(playButton);

    // Rebuild widgets
    await tester.pump();

    expect(find.text('Playing'), findsOneWidget);
  });
}
