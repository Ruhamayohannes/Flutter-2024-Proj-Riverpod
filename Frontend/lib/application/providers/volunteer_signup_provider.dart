import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/services/api_path.dart';  // Update this import to match the actual path

final volunteerSignupProvider =
    ChangeNotifierProvider((ref) => VolunteerSignupNotifier());

class VolunteerSignupNotifier extends ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? fullNameError;
  String? emailError;
  String? usernameError;
  String? passwordError;
  String? confirmPasswordError;
  String? _password;
  String? _fullName;
  String? _role;
  String? signupError;

  final RemoteService _remoteService = RemoteService();

  void setFullName(String value) {
    _fullName = value;
    if (value.isEmpty) {
      fullNameError = 'Please enter your full name';
    } else {
      fullNameError = null;
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

  void setRole(String role) {
    _role = role;
  }

  bool validateForm() {
    setFullName(fullNameController.text);
    setEmail(emailController.text);
    setUsername(usernameController.text);
    setPassword(passwordController.text);
    setConfirmPassword(confirmPasswordController.text);

    return fullNameError == null &&
        emailError == null &&
        usernameError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  Future<void> signUp(BuildContext context) async {
    if (validateForm()) {
      final responseMessage = await _remoteService.signUp(
        fullNameController.text,
        emailController.text,
        usernameController.text,
        passwordController.text,
        'user',  // Assuming the role is 'user'
      );

      if (responseMessage == null) {
        // Sign up successful
        context.go('/user_home'); // Navigate to user home
      } else {
        // Sign up failed, set error message
        signupError = responseMessage;
        notifyListeners();
      }
    } else {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
