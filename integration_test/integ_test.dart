import 'package:bloc_state_management/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('testing',
      (tester) async {
    // Load app widget.
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('User'), findsOneWidget);

  });
}
