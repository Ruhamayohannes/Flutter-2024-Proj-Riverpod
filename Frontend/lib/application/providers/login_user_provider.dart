import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final loginProvider = ChangeNotifierProvider((ref) => LoginNotifier());

class LoginNotifier extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;
  String? loginError;

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
    // Validate the form
    setUsername(usernameController.text);
    setPassword(passwordController.text);

    if (usernameError != null || passwordError != null) {
      return;
    }

    // Make the API request
    final response = await http.get(
      Uri.parse(
          'http://192.168.229.141:3000/auth/login?username=${usernameController.text}&password=${passwordController.text}'), // Replace with your actual backend URL and append the query parameters
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Successful login
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final status = responseBody['status'];

      // Navigate to the next screen based on the user's status
      if (status == 'user') {
        context.go('/user_home');
      } else if (status == 'agency') {
        context.go('/agency_home');
      } else {
        // Handle other statuses
      }
    } else {
      // Failed login
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
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
