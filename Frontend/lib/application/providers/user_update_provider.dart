import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends ChangeNotifier {
  String _username = '';
  String _password = '';
  String _email = '';
  String _name = '';

  String get username => _username;
  String get password => _password;
  String get email => _email;
  String get name => _name;

  void updateProfile({
    required String username,
    required String password,
    required String email,
    required String name,
  }) {
    _username = username;
    _password = password;
    _email = email;
    _name = name;
    notifyListeners();
  }

  void deleteAccount() {
    // Perform account deletion logic here, such as API calls or local data removal
    _username = '';
    _password = '';
    _email = '';
    _name = '';
    notifyListeners();
  }
}

final userProvider = ChangeNotifierProvider((ref) => UserProvider());
