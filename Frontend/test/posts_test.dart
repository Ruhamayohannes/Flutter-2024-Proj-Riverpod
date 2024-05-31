import 'package:flutter_test/flutter_test.dart';
import 'package:Sebawi/application/providers/posts_provider.dart';
import 'package:Sebawi/data/models/posts.dart';
import 'package:Sebawi/data/services/api_path.dart';

class TestRemoteService extends RemoteService {
  final List<Post>? testPosts;

  TestRemoteService(this.testPosts);

  @override
  Future<List<Post>?> getPosts() async {
    return testPosts;
  }
}

void main() {
  test('PostsNotifier fetches posts successfully', () async {
    // Arrange
    final posts = [
      Post(name: 'Post 1', description: 'Description 1', contact: 'Contact 1'),
      Post(name: 'Post 2', description: 'Description 2', contact: 'Contact 2'),
    ];

    final testService = TestRemoteService(posts);
    final postsNotifier = PostsNotifier(service: testService);

    // Act
    final result = await postsNotifier.build();

    // Assert
    expect(result, posts);
  });

  test('PostsNotifier handles empty post list', () async {
    // Arrange
    final testService = TestRemoteService([]);
    final postsNotifier = PostsNotifier(service: testService);

    // Act
    final result = await postsNotifier.build();

    // Assert
    expect(result, []);
  });

  test('PostsNotifier handles null post list', () async {
    // Arrange
    final testService = TestRemoteService(null);
    final postsNotifier = PostsNotifier(service: testService);

    // Act
    final result = await postsNotifier.build();

    // Assert
    expect(result, []);
  });
}
