import 'package:flutter_riverpod/flutter_riverpod.dart';


final usernameProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');


final loginStatusProvider = StateNotifierProvider<LoginStatusNotifier, bool>((ref) {
  return LoginStatusNotifier();
});

class LoginStatusNotifier extends StateNotifier<bool> {
  LoginStatusNotifier() : super(false);

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return false; 
    } else {
      
      return true;
    }
  }
}
