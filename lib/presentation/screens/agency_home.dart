import 'package:Sebawi/application/providers/agency_provider.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AgencyHomePage extends ConsumerWidget {
  const AgencyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agencyNotifier = ref.watch(agencyProvider.notifier);
    final posts = ref.watch(agencyProvider).posts;

    // Assuming the current user's posts can be identified somehow
    // Here we're just assuming the first half of the posts are the user's posts for demonstration
    final myPosts =
        posts.where((post) => post.agencyName == "Mekedonia").toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "All Posts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800),
                ),
              ),
              Tab(
                child: Text(
                  "My Posts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800),
                ),
              ),
              Tab(
                child: Text(
                  "Add Post",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800),
                ),
              ),
            ],
            labelColor: const Color.fromARGB(255, 255, 255, 255),
            unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
            indicatorColor: Color.fromARGB(255, 147, 176, 149),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0),
            child: Text("Sebawi",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.green.shade800)),
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
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ];
                },
                icon: Icon(Icons.logout),
                color: Colors.green.shade800,
                iconSize: 27,
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    PostItem(
                      post: posts[index],
                      isMyPost: true,
                      onDelete: () {
                        agencyNotifier.deletePost(index);
                      },
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.grey.shade200,
                    ),
                  ],
                );
              },
            ),
            ListView.builder(
              itemCount: myPosts.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    PostItem(
                      post: myPosts[index],
                      isMyPost: true,
                      onDelete: () {
                        agencyNotifier.deletePost(index);
                      },
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.grey.shade200,
                    ),
                  ],
                );
              },
            ),
            AddPostForm(),
          ],
        ),
      ),
    );
  }
}

class AddPostForm extends ConsumerStatefulWidget {
  const AddPostForm({super.key});

  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends ConsumerState<AddPostForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(labelText: 'Contact'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              buttonText: 'Post',
              buttonColor: Color.fromARGB(255, 255, 255, 255),
              buttonTextColor: const Color.fromARGB(255, 33, 94, 35),
              buttonAction: () {
                if (_formKey.currentState!.validate()) {
                  final newPost = Post(
                    agencyName:
                        "Mekedonia", // Example for current user's agency
                    contactInfo: _contactController.text,
                    serviceType: _descriptionController.text,
                  );
                  ref.read(agencyProvider.notifier).addPost(newPost);
                  _nameController.clear();
                  _descriptionController.clear();
                  _contactController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying a single post
class PostItem extends StatelessWidget {
  final Post post;
  final bool isMyPost;
  final VoidCallback onDelete;

  const PostItem({
    required this.post,
    required this.isMyPost,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade100,
            ], // You can adjust these colors as needed
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              post.agencyName,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.green.shade800),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.phone_android,
                      size: 14, color: Colors.green.shade800),
                  const Text(
                    " Contact: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(post.contactInfo),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.medical_services,
                      size: 14, color: Colors.green.shade800),
                  const Center(
                    child: Text(
                      " Service Type: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(post.serviceType),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isMyPost) ...[
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey.shade900,
                        ),
                        onPressed: () {
                          openDialog(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade700,
                        ),
                        onPressed: onDelete,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Edit Post',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Agency Name',
                  hintText: 'Enter the name of the agency',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contact Info',
                  hintText: 'Enter the contact information',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Service Type',
                  hintText: 'Enter the type of service',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.redAccent.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                ),
              ),
              child: const Text(
                'Discard',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.green.shade800),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                ),
              ),
              child: const Text(
                'Save Changes',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
