import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:Sebawi/application/providers/login_admin_provider.dart';

void main() {
  group('LoginNotifier', () {
    test('initial state is false', () {
      final loginNotifier = LoginNotifier();
      expect(loginNotifier.state, isFalse);
    });

    test('login sets state to true with correct credentials', () {
      final loginNotifier = LoginNotifier();
      loginNotifier.login('admin', 'password');
      expect(loginNotifier.state, isTrue);
    });

    test('login sets state to false with incorrect credentials', () {
      final loginNotifier = LoginNotifier();
      loginNotifier.login('admin', 'wrongpassword');
      expect(loginNotifier.state, isFalse);
    });
  });
}
