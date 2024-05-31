import 'dart:convert';


import '../models/posts.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.229.141:3000/posts');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return (null);
    }
  }

  Future<int?> addPost(post) async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.229.141:3000/posts');
    final response = await client.post(uri,
        headers: {'Content-Type': 'application/json'}, body: json.encode(post));
      return response.statusCode;
  }
}

