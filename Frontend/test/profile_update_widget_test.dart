import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Sebawi/presentation/widgets/profile_update.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/main.dart';

void main() {
  testWidgets('ProfileUpdate displays form fields and buttons correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileUpdate(),
        ),
      ),
    );

    // Verify the presence of form fields
    expect(find.byType(TextFormField), findsNWidgets(5)); // Adjusted to find 5 TextFormFields
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.text('Delete Account'), findsOneWidget);

    // Verify the AppBar title
    expect(find.widgetWithText(AppBar, 'Update Profile'), findsOneWidget);

    // Verify the button text
    expect(find.widgetWithText(CustomButton, 'Update Profile'), findsOneWidget);
  });

  testWidgets('ProfileUpdate validates form fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileUpdate(),
        ),
      ),
    );

    // Tap the update profile button
    await tester.tap(find.widgetWithText(CustomButton, 'Update Profile'), warnIfMissed: false);
    await tester.pump();

    // Verify validation messages
    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your username'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    // Enter invalid email and verify validation
    await tester.enterText(find.byType(TextFormField).at(2), 'invalid_email');
    await tester.tap(find.widgetWithText(CustomButton, 'Update Profile'), warnIfMissed: false);
    await tester.pump();
    expect(find.text('Please enter a valid email address'), findsOneWidget);
  });

  testWidgets('ProfileUpdate updates profile on valid input', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileUpdate(),
        ),
      ),
    );

    // Enter valid data in all fields
    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextFormField).at(1), 'johndoe');
    await tester.enterText(find.byType(TextFormField).at(2), 'john@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'password123');
    await tester.enterText(find.byType(TextFormField).at(4), 'password123');

    // Tap the update profile button
    await tester.tap(find.widgetWithText(CustomButton, 'Update Profile'), warnIfMissed: false);
    await tester.pump();

    // Verify the Snackbar is displayed
    expect(find.text('Profile updated'), findsOneWidget);
  });

  testWidgets('ProfileUpdate delete account button works', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileUpdate(),
        ),
      ),
    );

    // Tap the delete account button
    await tester.tap(find.text('Delete Account'), warnIfMissed: false);
    await tester.pump();

    // Verify delete confirmation dialog
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Delete Account'), findsWidgets); // findsWidgets to account for the button and dialog title
    expect(find.text('Are you sure you want to delete your account? This action cannot be undone.'), findsOneWidget);
  });
}
