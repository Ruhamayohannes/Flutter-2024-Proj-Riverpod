import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/login?username=$username&password=$password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      
    } else {
      throw Exception('Failed to login');
    }
  }
}
