import 'package:http/http.dart' as http;
import '../models/posts_model.dart'; // Import your Post model
import '../models/users_model.dart'; // Import your User model


class AdminApi {
  final String baseUrl;

  AdminApi({required this.baseUrl});

  Future<List<Post>?> getPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        return postFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching posts: $e');
      return null;
    }
  }

  Future<List<User>?> getUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user'));
      if (response.statusCode == 200) {
        return userFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching users: $e');
      return null;
    }
  }

  // Future<List<Agency>?> getAgencies() async {
  //   try {
  //     final response = await http.get(Uri.parse('$baseUrl/agencies'));
  //     if (response.statusCode == 200) {
  //       return agencyFromJson(response.body);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error fetching agencies: $e');
  //     return null;
  //   }
  // }
}
