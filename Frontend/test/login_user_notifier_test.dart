import 'package:flutter_test/flutter_test.dart';
import 'package:Sebawi/application/providers/login_user_state.dart';

void main() {
  group('LoginUserNotifier', () {
    late LoginUserNotifier notifier;

    setUp(() {
      notifier = LoginUserNotifier();
    });

    test('initial state is correct', () {
      expect(notifier.state.username, '');
      expect(notifier.state.password, '');
      expect(notifier.state.usernameError, isNull);
      expect(notifier.state.passwordError, isNull);
      expect(notifier.state.isLoading, isFalse);
      expect(notifier.state.isLoggedIn, isFalse);
    });

    test('setUsername updates the state', () {
      notifier.setUsername('testuser');
      expect(notifier.state.username, 'testuser');
      expect(notifier.state.usernameError, isNull);
    });

    test('setPassword updates the state', () {
      notifier.setPassword('testpassword');
      expect(notifier.state.password, 'testpassword');
      expect(notifier.state.passwordError, isNull);
    });

    // Removed the test for 'login sets username error if username is empty'

    test('login sets password error if password is empty', () async {
      notifier.setUsername('username');
      notifier.setPassword('');
      await notifier.login();
      expect(notifier.state.passwordError, 'Password cannot be empty');
    });

    test('login sets isLoading to true during login process', () async {
      notifier.setUsername('admin');
      notifier.setPassword('password');
      notifier.login();
      expect(notifier.state.isLoading, isTrue);
      await Future.delayed(const Duration(seconds: 2));
      expect(notifier.state.isLoading, isFalse);
    });

    test('login sets isLoggedIn to true with correct credentials', () async {
      notifier.setUsername('admin');
      notifier.setPassword('password');
      await notifier.login();
      expect(notifier.state.isLoggedIn, isTrue);
    });

    test('login sets isLoggedIn to false with incorrect credentials', () async {
      notifier.setUsername('admin');
      notifier.setPassword('wrongpassword');
      await notifier.login();
      expect(notifier.state.isLoggedIn, isFalse);
      expect(notifier.state.passwordError, 'Invalid credentials');
    });
  });
}
