import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/services/auth_service.dart'; // Import the AuthService

final adminLoginProvider = ChangeNotifierProvider<AdminLoginNotifier>((ref) {
  final authService = AuthService(baseUrl: 'http://192.168.211.141:3000');
  return AdminLoginNotifier(authService);
});

class AdminLoginNotifier extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService;

  String? usernameError;
  String? passwordError;
  String? loginError;

  AdminLoginNotifier(this.authService);

  void setUsername(String value) {
    if (value.isEmpty) {
      usernameError = 'Please enter a username';
    } else {
      usernameError = null;
    }
    notifyListeners();
  }

  void setPassword(String value) {
    if (value.isEmpty) {
      passwordError = 'Please enter a password';
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    setUsername(usernameController.text);
    setPassword(passwordController.text);

    if (usernameError != null || passwordError != null) {
      return;
    }

    try {
      final responseBody = await authService.login(
          usernameController.text, passwordController.text);
      final status = responseBody['status'];

      if (status == 'admin') {
        context.go('/admin_page');
      } else {
        loginError = 'You are not authorized as admin';
        notifyListeners();
      }
    } catch (e) {
      loginError = 'Failed to login';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
