import 'package:flutter_test/flutter_test.dart';
import 'package:kidycare/main.dart';

void main() {
  testWidgets('KidyCareApp loads without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KidyCareApp());

    // Simple smoke test: verify that the root widget is present.
    expect(find.byType(KidyCareApp), findsOneWidget);
  });
}
