// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/main.dart';

void main() {
  testWidgets('App displays welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verifica que se muestra el título "Welcome to Flutter"
    expect(find.text('Welcome to Flutter'), findsOneWidget);

    // Verifica que se muestra "Hello World" en el centro
    expect(find.text('Hello World'), findsOneWidget);

    print('✓ Prueba pasada: Se encontraron los textos correctos');
  });
}
