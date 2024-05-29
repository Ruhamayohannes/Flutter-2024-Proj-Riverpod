import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Post {
  final String agencyName;
  final String contactInfo;
  final String serviceType;

  Post({
    required this.agencyName,
    required this.contactInfo,
    required this.serviceType,
  });
}

class AgencyProvider extends ChangeNotifier {
  final List<Post> _posts = [
    Post(
      agencyName: "Mekedonia",
      contactInfo: "09113124",
      serviceType: "Money and Labor",
    ),
    Post(
      agencyName: "Gergesenon",
      contactInfo: "09113523",
      serviceType: "Sanitary Products",
    ),
    Post(
      agencyName: "Mekedonia",
      contactInfo: "09113124",
      serviceType: "Money and Labor",
    ),
    Post(
      agencyName: "Mekedonia",
      contactInfo: "09113124",
      serviceType: "Money and Labor",
    ),
  ];

  List<Post> get posts => _posts;

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
}

final agencyProvider = ChangeNotifierProvider((ref) => AgencyProvider());
