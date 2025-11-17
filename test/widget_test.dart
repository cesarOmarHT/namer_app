// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/main.dart';

void main() {
  testWidgets('App displays main widgets correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

  expect(find.text('Widgets en Flutter'), findsOneWidget);

  expect(find.text('Ejemplo con Widgets básicos'), findsOneWidget);

  expect(find.text('Generar nueva palabra'), findsOneWidget);

    print('✓ Prueba pasada: Los widgets principales están visibles');
  });
}
