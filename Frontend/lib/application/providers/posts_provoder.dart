import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/models/posts.dart';
import 'package:Sebawi/data/services/api_path.dart';

class PostsNotifier extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() async {
    return await _fetchPosts();
  }

  Future<List<Post>> _fetchPosts() async {
    final service = RemoteService();
    return await service.getPosts() ?? [];
  }
}

final postsProvider = AsyncNotifierProvider<PostsNotifier, List<Post>>(() {
  return PostsNotifier();
});
