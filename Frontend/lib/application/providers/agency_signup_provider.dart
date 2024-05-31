import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/services/api_path.dart';

final agencySignupProvider = ChangeNotifierProvider((ref) => AgencySignupNotifier());

class AgencySignupNotifier extends ChangeNotifier {
  final TextEditingController agencyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? agencyNameError;
  String? emailError;
  String? usernameError;
  String? passwordError;
  String? confirmPasswordError;
  String? _password;
  String? signupError;

  final RemoteService _remoteService = RemoteService();

  void setAgencyName(String value) {
    if (value.isEmpty) {
      agencyNameError = 'Please enter your agency name';
    } else {
      agencyNameError = null;
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
    setAgencyName(agencyNameController.text);
    setEmail(emailController.text);
    setUsername(usernameController.text);
    setPassword(passwordController.text);
    setConfirmPassword(confirmPasswordController.text);

    return agencyNameError == null &&
        emailError == null &&
        usernameError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  Future<void> signUp(BuildContext context) async {
    if (validateForm()) {
      final responseMessage = await _remoteService.signUp(
        agencyNameController.text,
        emailController.text,
        usernameController.text,
        passwordController.text,
        'agency',
      );

      if (responseMessage == null) {
        context.go('/agency_home');
      } else {
        signupError = responseMessage;
        notifyListeners();
      }
    } else {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    agencyNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
