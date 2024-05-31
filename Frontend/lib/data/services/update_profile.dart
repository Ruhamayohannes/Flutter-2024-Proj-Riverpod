import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> updateUserProfile(String userId, String username, String email,
    String password, String name) async {
  try {
    final uri = Uri.parse('http://192.168.211.141:3000/user/$userId/profile');

    final response = await http.patch(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'name': name,
      }),
    );

    if (response.statusCode == 200) {
      return null; // Profile updated successfully
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Failed to update profile';
    }
  } catch (e) {
    return 'Failed to connect to server'; // Handle connection error
  }
}
