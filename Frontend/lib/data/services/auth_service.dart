import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<String> login(String username, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/login?username=$username&password=$password'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody.containsKey('token')) {
        return responseBody['token'];
      } else {
        throw Exception('Token not found in response');
      }
    } else {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }
}
