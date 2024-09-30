import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/presentation/screens/volunteer_signup.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';

void main() {
  testWidgets('VolunteerSignup displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: VolunteerSignup(),
        ),
      ),
    );

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
}
