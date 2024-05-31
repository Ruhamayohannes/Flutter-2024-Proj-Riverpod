import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/application/providers/agency_update_provider.dart';

void main() {
  group('AgencyUpdateProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial values are correct', () {
      // Act
      final agencyUpdateProviderInstance = container.read(agencyUpdateProvider);

      // Assert
      expect(agencyUpdateProviderInstance.agencyName, '');
      expect(agencyUpdateProviderInstance.agencyEmail, '');
      expect(agencyUpdateProviderInstance.password, '');
    });

    test('Update profile updates the values correctly', () {
      // Arrange
      final agencyUpdateProviderInstance = container.read(agencyUpdateProvider);

      // Act
      agencyUpdateProviderInstance.updateProfile(
        agencyName: 'Test Agency',
        agencyEmail: 'test@agency.com',
        password: 'password123',
      );

      // Assert
      expect(agencyUpdateProviderInstance.agencyName, 'Test Agency');
      expect(agencyUpdateProviderInstance.agencyEmail, 'test@agency.com');
      expect(agencyUpdateProviderInstance.password, 'password123');
    });

    test('Delete account resets the values correctly', () {
      // Arrange
      final agencyUpdateProviderInstance = container.read(agencyUpdateProvider);
      agencyUpdateProviderInstance.updateProfile(
        agencyName: 'Test Agency',
        agencyEmail: 'test@agency.com',
        password: 'password123',
      );

      // Act
      agencyUpdateProviderInstance.deleteAccount();

      // Assert
      expect(agencyUpdateProviderInstance.agencyName, '');
      expect(agencyUpdateProviderInstance.agencyEmail, '');
      expect(agencyUpdateProviderInstance.password, '');
    });
  });
}
