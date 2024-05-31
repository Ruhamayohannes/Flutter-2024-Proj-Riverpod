import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  String? _role; // Role to be set from SignupNotifier

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
      final result = await signUpApi(
        fullNameController.text,
        emailController.text,
        usernameController.text,
        passwordController.text,
        _role!, // Ensure role is set
      );

      if (result == null) {
        // Sign up successful
        context.go('/user_home'); // Navigate to user home
      } else {
        // Sign up failed, handle error
        // Show error message (this could be improved to show a user-friendly message in the UI)
        print(result);
      }
    } else {
      notifyListeners();
    }
  }

  Future<String?> signUpApi(String fullName, String email, String username,
      String password, String role) async {
    final response = await http.post(
      Uri.parse('http://192.168.229.141:3000/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': fullName,
        "username": username,
        'email': email,
        'password': password,
        'role': role,
      }),
    );
    if (response.statusCode == 201) {
      print("success");
      return null;
    } else {
      print(response.statusCode);
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Failed to sign up';
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
