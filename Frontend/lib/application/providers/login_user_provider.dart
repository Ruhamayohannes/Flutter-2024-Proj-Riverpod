import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/services/api_path.dart'; 

// Define providers for login
final loginProvider = ChangeNotifierProvider((ref) => LoginNotifier());

class LoginNotifier extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;
  String? loginError;
  String? token; // Store the token

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
    } else if (value.length < 6) {
      passwordError = 'Password must be at least 6 characters';
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  bool validateForm() {
    setUsername(usernameController.text);
    setPassword(passwordController.text);

    return usernameError == null && passwordError == null;
  }

  Future<void> login(BuildContext context) async {
    if (validateForm()) {
      try {
        final result = await logIn(
          usernameController.text,
          passwordController.text,
        );
        if (result == null) {
          // Login successful
          token = 'some_token'; // Replace with actual token
          print('Login successful: $token');
          context.go('/user_home');
        } else {
          loginError = result;
          notifyListeners();
        }
      } catch (e) {
        loginError = 'Login failed. Please try again.';
        notifyListeners();
      }
    } else {
      print('Validation failed');
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