import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/models/posts_model.dart';
import 'package:Sebawi/data/services/api_path.dart';

class MyPostsNotifier extends AsyncNotifier<List<Post>?> {
  @override
  Future<List<Post>?> build() async {
    return await _fetchMyPosts();
  }

  Future<List<Post>?> _fetchMyPosts() async {
    final service = RemoteService();
    return await service.getMyPosts() ?? [];
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchMyPosts());
  }
}

final myPostsProvider = AsyncNotifierProvider<MyPostsNotifier, List<Post>?>(() {
  return MyPostsNotifier();
});
