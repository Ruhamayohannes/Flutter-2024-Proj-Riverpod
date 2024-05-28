import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider = StateProvider<List<Post>>((ref) => []);

class Post {
  final String id;
  final String title;
  final String content;
  final String date;

  Post({required this.id, required this.title, required this.content, required this.date});
  
  // You can add methods here for post management, such as fetching posts from an API, creating new posts, deleting posts, etc.
}
