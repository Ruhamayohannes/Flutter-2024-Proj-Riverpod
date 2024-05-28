import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersProvider = StateProvider<List<User>>((ref) => []);

class User {
  final String id;
  final String username;
  final String email;

  User({required this.id, required this.username, required this.email});
  
  // You can add methods here for user management, such as fetching users from an API, updating user details, etc.
}
