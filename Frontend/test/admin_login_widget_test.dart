import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/presentation/screens/admin_login.dart';

void main() {
  testWidgets('AdminLoginPage displays correctly', (WidgetTester tester) async {
    // Build the AdminLoginPage widget
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: AdminLoginPage(),
        ),
      ),
    );

    // Verify the initial UI elements
    expect(find.text('Admin Login'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
