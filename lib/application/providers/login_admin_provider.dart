import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier() : super(false);

  void login(String username, String password) {
    if (username == 'admin' && password == 'password') {
      state = true;
    } else {
      state = false;
    }
  }
}


final loginProvider = StateNotifierProvider<LoginNotifier, bool>((ref) {
  return LoginNotifier();
});
