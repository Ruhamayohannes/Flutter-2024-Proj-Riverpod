import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileProvider extends ChangeNotifier {
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
    notifyListeners();
  }
}

final profileProvider = ChangeNotifierProvider((ref) => ProfileProvider());
