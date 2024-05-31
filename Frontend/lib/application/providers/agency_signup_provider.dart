import 'dart:convert';

import 'package:Sebawi/application/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;


final agencySignupProvider =
    ChangeNotifierProvider((ref) => AgencySignupNotifier());

class AgencySignupNotifier extends ChangeNotifier {
  final TextEditingController agencyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? agencyNameError;
  String? emailError;
  String? usernameError;
  String? passwordError;
  String? confirmPasswordError;
  String? _password;
  String? _agencyName;
  String? _role;
  String? signupError;

  void setagencyName(String value) {
    _agencyName = value;
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
    setagencyName(agencyNameController.text);
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
      final responseMessage = await signUpApi(
        agencyNameController.text,
        emailController.text,
        usernameController.text,
        passwordController.text,
      );

      if (responseMessage == null) {
        // Sign up successful
        context.go('/agency_home'); // Navigate to user home
      } else {
        // Sign up failed, set error message
        signupError = responseMessage;
        notifyListeners();
      }
    } else {
      notifyListeners();
    }
  }

  Future<String?> signUpApi(String agencyName, String email, String username,
      String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.229.141:3000/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': agencyName,
          "username": username,
          'email': email,
          'password': password,
          'role': 'agency',
        }),
      );
      
      if (response.statusCode == 201) {
        print("success");
        return null; // Sign up successful
      } else {
        print(response.statusCode);
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody['message'] ?? 'Failed to sign up';
      }
    } catch (e) {
      return 'Failed to connect to server'; // Handle connection error
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
