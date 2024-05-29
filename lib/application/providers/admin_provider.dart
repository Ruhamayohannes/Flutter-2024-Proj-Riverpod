import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Post {
  String title;
  String content;
  String date;

  Post({required this.title, required this.content, required this.date});
}

class User {
  String name;
  String email;

  User({required this.name, required this.email});
}

class Agency {
  String name;
  String email;

  Agency({required this.name, required this.email});
}

class AdminProvider extends ChangeNotifier {
  final List<Post> _posts = [
    Post(
      title: "Event in Central Park",
      content: "Details about the event...",
      date: "2024-04-18",
    ),
  ];

  final List<User> _users = [
    User(
      name: "John Doe",
      email: "john.doe@example.com",
    ),
  ];

  final List<Agency> _agencies = [
    Agency(
      name: "Good Agency",
      email: "contact@goodagency.com",
    ),
  ];

  List<Post> get posts => _posts;
  List<User> get users => _users;
  List<Agency> get agencies => _agencies;

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }

  void updatePost(int index, Post updatedPost) {
    _posts[index] = updatedPost;
    notifyListeners();
  }

  void deletePost(int index) {
    _posts.removeAt(index);
    notifyListeners();
  }

  void deleteUser(int index) {
    _users.removeAt(index);
    notifyListeners();
  }

  void deleteAgency(int index) {
    _agencies.removeAt(index);
    notifyListeners();
  }
}

final adminProvider = ChangeNotifierProvider((ref) => AdminProvider());
