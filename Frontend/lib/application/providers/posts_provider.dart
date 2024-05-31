import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/models/posts_model.dart';
import 'package:Sebawi/data/services/api_path.dart';

class PostsNotifier extends AsyncNotifier<List<Post>?> {
  @override
  Future<List<Post>?> build() async {
    return await _fetchPosts();
  }

  Future<List<Post>?> _fetchPosts() async {
    final service = RemoteService();
    return await service.getPosts() ?? [];
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPosts());
  }
}

final postsProvider = AsyncNotifierProvider<PostsNotifier, List<Post>?>(() {
  return PostsNotifier();
});
