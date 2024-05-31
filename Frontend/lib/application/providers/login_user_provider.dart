import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/services/api_path.dart'; // Import the AuthService

final loginProvider = ChangeNotifierProvider<LoginNotifier>((ref) {
  final remoteService = RemoteService(); // Use RemoteService
  return LoginNotifier(remoteService);
});

class LoginNotifier extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RemoteService remoteService;

  String? usernameError;
  String? passwordError;
  String? loginError;

  LoginNotifier(this.remoteService); // Initialize RemoteService directly in the constructor

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
      final responseBody = await remoteService.logIn(
          usernameController.text, passwordController.text);
      final status = responseBody['status'];
      if (status == 'user') {
        context.go('/user_home');
      } else if (status == 'agency') {
        context.go('/agency_home');
      } else if (status == 'admin') {
        context.go('/admin');
      } else {
        loginError = responseBody['message'] ?? 'Failed to login';
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
