import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_lab/main.dart';

void main() {
  testWidgets('App inicia con Netflix Lab', (WidgetTester tester) async {
    await tester.pumpWidget(const NetflixLabApp());
    expect(find.text('Reproducir'), findsNothing);
  });
}
