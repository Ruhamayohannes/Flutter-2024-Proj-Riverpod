import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final volunteerSignupProvider = ChangeNotifierProvider((ref) => VolunteerSignupNotifier());

class VolunteerSignupNotifier extends ChangeNotifier {
  String fullName = '';
  String email = '';
  String username = '';
  String password = '';
  String confirmPassword = '';

  void setFullName(String value) {
    fullName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    // Implement your signup logic here
    // For demonstration purposes, just navigate to user_home route
    context.go('/user_home');
  }
}
