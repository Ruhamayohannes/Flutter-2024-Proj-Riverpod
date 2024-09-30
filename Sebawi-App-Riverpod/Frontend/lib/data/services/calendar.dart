import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CalendarService {
  final String baseUrl;

  CalendarService({required this.baseUrl});

  Future<Map<String, dynamic>> createEvent(String postId, Map<String, dynamic> createEventDto) async {
    final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('auth_token') ?? '';

    // if (token.isEmpty) {
    //   throw Exception('No authentication token found');
    // }

    final url = Uri.parse('$baseUrl/add/$postId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token', // Assuming the token is used in this format
      },
      body: jsonEncode(createEventDto),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create event: ${response.statusCode} - ${response.body}');
    }
  }
}
