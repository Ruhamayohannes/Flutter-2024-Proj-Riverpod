import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart'; // Adjust this import according to your project structure

void main() {
  testWidgets('CustomButton displays correct text and performs action',
      (WidgetTester tester) async {
    // Define a test key to find the widget
    final testKey = const Key('customButton');

    // Define a variable to track button press
    bool buttonPressed = false;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            key: testKey,
            buttonText: 'Press Me',
            buttonColor: Colors.blue,
            buttonTextColor: Colors.white,
            buttonAction: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Verify the button text
    expect(find.text('Press Me'), findsOneWidget);

    // Verify the button is of type CustomButton
    expect(find.byType(CustomButton), findsOneWidget);

    // Tap the button and verify the action
    await tester.tap(find.byKey(testKey));
    await tester.pump();

    expect(buttonPressed, isTrue);
  });
}
