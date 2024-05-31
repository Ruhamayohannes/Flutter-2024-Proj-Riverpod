import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final signupProvider = ChangeNotifierProvider((ref) => SignupNotifier());

class SignupNotifier extends ChangeNotifier {
  String? role;

  void setRole(String selectedRole) {
    role = selectedRole;
    notifyListeners();
  }

  void navigateToVolunteerSignup(BuildContext context) {
    setRole('volunteer');
    context.go('/volunteer_signup');
  }

  void navigateToAgencySignup(BuildContext context) {
    setRole('agency');
    context.go('/agency_signup');
  }
}
