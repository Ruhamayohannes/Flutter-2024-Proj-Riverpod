import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/application/providers/agency_signup_provider.dart';

void main() {
  group('AgencySignupNotifier', () {
    late ProviderContainer container;
    late AgencySignupNotifier agencySignupNotifier;

    setUp(() {
      container = ProviderContainer();
      agencySignupNotifier = container.read(agencySignupProvider);
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial values are correct', () {
      expect(agencySignupNotifier.agencyNameController.text, '');
      expect(agencySignupNotifier.emailController.text, '');
      expect(agencySignupNotifier.usernameController.text, '');
      expect(agencySignupNotifier.passwordController.text, '');
      expect(agencySignupNotifier.confirmPasswordController.text, '');
    });

    test('setAgencyName sets the agency name correctly', () {
      agencySignupNotifier.setAgencyName('Test Agency');
      expect(agencySignupNotifier.agencyNameError, isNull);
    });

    test('setEmail sets the email correctly', () {
      agencySignupNotifier.setEmail('test@agency.com');
      expect(agencySignupNotifier.emailError, isNull);
    });

    test('validateForm returns true when the form is valid', () {
      agencySignupNotifier.agencyNameController.text = 'Test Agency';
      agencySignupNotifier.emailController.text = 'test@agency.com';
      agencySignupNotifier.usernameController.text = 'username';
      agencySignupNotifier.passwordController.text = 'password123';
      agencySignupNotifier.confirmPasswordController.text = 'password123';

      expect(agencySignupNotifier.validateForm(), isTrue);
    });

    test('validateForm returns false when the form is invalid', () {
      agencySignupNotifier.agencyNameController.text = '';
      agencySignupNotifier.emailController.text = 'invalid-email';
      agencySignupNotifier.usernameController.text = '';
      agencySignupNotifier.passwordController.text = 'pass';
      agencySignupNotifier.confirmPasswordController.text = 'different_pass';

      expect(agencySignupNotifier.validateForm(), isFalse);
    });
  });
}
