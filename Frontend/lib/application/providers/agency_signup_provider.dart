import 'package:Sebawi/application/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final agencySignupProvider =
    ChangeNotifierProvider((ref) => AgencySignupNotifier());

class AgencySignupNotifier extends ChangeNotifier {
  final TextEditingController agnecyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? agnecyNameError;
  String? emailError;
  String? usernameError;
  String? passwordError;
  String? confirmPasswordError;
  String? _password;
  String? _agnecyName;

  void setAgnecyName(String value) {
    _agnecyName = value;
    if (value.isEmpty) {
      agnecyNameError = 'Please enter your agnecy name';
    } else {
      agnecyNameError = null;
    }
    notifyListeners();
  }

  void setEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      emailError = 'Please enter a valid email';
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void setUsername(String value) {
    if (value.isEmpty) {
      usernameError = 'Please enter a username';
    } else {
      usernameError = null;
    }
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    if (value.isEmpty) {
      passwordError = 'Please enter a password';
    } else if (value.length < 6) {
      passwordError = 'Password must be at least 6 characters';
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError = 'Please confirm your password';
    } else if (value != _password) {
      confirmPasswordError = 'Passwords do not match';
    } else {
      confirmPasswordError = null;
    }
    notifyListeners();
  }

  bool validateForm() {
    setAgnecyName(agnecyNameController.text);
    setEmail(emailController.text);
    setUsername(usernameController.text);
    setPassword(passwordController.text);
    setConfirmPassword(confirmPasswordController.text);

    return agnecyNameError == null &&
        emailError == null &&
        usernameError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  Future<void> signUp(BuildContext context) async {
    if (validateForm()) {
      print('Signup successful');
      context.go('/agency_home');
    } else {
      print('Validation failed');
      notifyListeners();
    }
  }

  @override
  void dispose() {
    agnecyNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
