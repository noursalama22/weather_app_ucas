import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/main.dart';

void main() {
  testWidgets('Weather app launches', (WidgetTester tester) async {
    await tester.pumpWidget(const WeatherApp());

    expect(find.text('Weather App'), findsOneWidget);
    expect(find.text('No weather loaded yet'), findsOneWidget);
  });
}
