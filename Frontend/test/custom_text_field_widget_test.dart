import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';


void main() {
  testWidgets('CustomTextFormField basic functionality', (WidgetTester tester) async {
    String inputText = '';
    final TextEditingController controller = TextEditingController();

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(
            labelText: 'Test Label',
            obscureText: true,
            onChanged: (value) {
              inputText = value;
            },
            validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null,
            controller: controller,
            onChange: (value) {},
          ),
        ),
      ),
    );

    // Verify the label text is displayed correctly
    expect(find.text('Test Label'), findsOneWidget);

    // Enter text and verify the onChanged callback
    await tester.enterText(find.byType(TextFormField), 'Test Input');
    await tester.pump();  // Ensure all animations and frame rendering are complete
    expect(inputText, 'Test Input');

    // Verify the obscureText property by accessing the underlying TextField widget
    final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
    expect(textFieldWidget.obscureText, isTrue);
  });
}
