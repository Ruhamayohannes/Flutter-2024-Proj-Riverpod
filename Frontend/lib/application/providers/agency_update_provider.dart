import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgencyProvider extends ChangeNotifier {
  String _agencyName = '';
  String _agencyEmail = '';
  String _password = '';

  String get agencyName => _agencyName;
  String get agencyEmail => _agencyEmail;
  String get password => _password;

  void updateProfile({
    required String agencyName,
    required String agencyEmail,
    required String password,
  }) {
    _agencyName = agencyName;
    _agencyEmail = agencyEmail;
    _password = password;
    notifyListeners();
  }

  void deleteAccount() {
    // Perform account deletion logic here, such as API calls or local data removal
    _agencyName = '';
    _agencyEmail = '';
    _password = '';
    notifyListeners();
  }
}

final agencyProvider = ChangeNotifierProvider((ref) => AgencyProvider());
