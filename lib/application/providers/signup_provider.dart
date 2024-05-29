import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final signupProvider = ChangeNotifierProvider((ref) => SignupNotifier());

class SignupNotifier extends ChangeNotifier {
  void navigateToVolunteerSignup(BuildContext context) {
    context.go("/volunteer_signup");
  }

  void navigateToAgencySignup(BuildContext context) {
    context.go('/agency_signup');
  }
}
