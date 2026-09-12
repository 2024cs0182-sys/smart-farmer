import 'package:flutter_test/flutter_test.dart';
import 'package:farmer_app/main.dart';

void main() {
  testWidgets('Smart Farmer app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartFarmerApp());

    expect(find.text('Nearby Procurement Centres'), findsOneWidget);
  });
}