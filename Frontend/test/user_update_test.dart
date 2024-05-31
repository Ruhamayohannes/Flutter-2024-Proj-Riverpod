import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/presentation/screens/volunteer_signup.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';

void main() {
  testWidgets('VolunteerSignup displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: VolunteerSignup(),
        ),
      ),
    );

    // Verify if the initial elements are present
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Do something good today.'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Full name'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Enter Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Create Username'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Create Password'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Confirm Password'), findsOneWidget);
    expect(find.widgetWithText(CustomButton, 'Signup'), findsOneWidget);
    expect(find.text('Already signed up?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Sign up button triggers sign up action', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: VolunteerSignup(),
        ),
      ),
    );

    // Enter text in the required fields
    await tester.enterText(find.widgetWithText(TextFormField, 'Full name'), 'John Doe');
    await tester.enterText(find.widgetWithText(TextFormField, 'Enter Email'), 'john.doe@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Create Username'), 'johndoe');
    await tester.enterText(find.widgetWithText(TextFormField, 'Create Password'), 'password123');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'password123');

    // Tap the signup button
    await tester.tap(find.text('Signup'));
    await tester.pump();

    // Verify the signup action is triggered (e.g., check for error message or navigation)
    // This depends on how the signup action is implemented in the notifier
    // For example, you can check for a success message or some change in the UI
  });

  testWidgets('Navigate to login page when "Login" text is clicked', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: VolunteerSignup(),
        ),
      ),
    );

    // Tap the "Login" text
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify if the navigation is triggered
    // This depends on the navigation implementation
    // For example, you can check if the correct route is pushed
  });
}
