import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/application/providers/admin_provider.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.green.shade800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  context.go('/login');
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              icon: const Icon(Icons.logout),
              color: Colors.green.shade800,
              iconSize: 27,
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.person),
              text: 'Manage Users',
            ),
            Tab(icon: Icon(Icons.business), text: 'Manage Agencies'),
            Tab(icon: Icon(Icons.post_add), text: 'Manage Posts'),
          ],
          indicatorColor: Colors.green.shade800,
          unselectedLabelColor: Colors.green.shade800,
          labelColor: Colors.green.shade800,
          indicatorWeight: 3,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildManageUsersTab(),
          _buildManageAgenciesTab(),
          _buildManagePostsTab(),
        ],
      ),
    );
  }

  Widget _buildManageUsersTab() {
    return Consumer(
      builder: (context, ref, _) {
        final users = ref.watch(adminProvider).users;
        final adminNotifier = ref.watch(adminProvider.notifier);

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.green.shade900,
                child: ListTile(
                  title: Text(users[index].name,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(users[index].email,
                      style: const TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      adminNotifier.deleteUser(index);
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildManageAgenciesTab() {
    return Consumer(
      builder: (context, ref, _) {
        final agencies = ref.watch(adminProvider).agencies;
        final adminNotifier = ref.watch(adminProvider.notifier);

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
            itemCount: agencies.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.green.shade900,
                child: ListTile(
                  title: Text(agencies[index].name,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(agencies[index].email,
                      style: const TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      adminNotifier.deleteAgency(index);
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildManagePostsTab() {
    return Consumer(
      builder: (context, ref, _) {
        final posts = ref.watch(adminProvider).posts;
        final adminNotifier = ref.watch(adminProvider.notifier);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'Your Posts',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.green.shade900,
                      child: ListTile(
                        title: Text(posts[index].title,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Posted on ${posts[index].date}',
                            style: const TextStyle(color: Colors.white70)),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.white,
                              onPressed: () {
                                _showEditDialog(context, adminNotifier,
                                    posts[index], index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                adminNotifier.deletePost(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(
      BuildContext context, AdminProvider adminNotifier, Post post, int index) {
    final titleController = TextEditingController(text: post.title);
    final contentController = TextEditingController(text: post.content);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedPost = Post(
                  title: titleController.text,
                  content: contentController.text,
                  date: post.date, // Keep the original date
                );
                adminNotifier.updatePost(index, updatedPost);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
