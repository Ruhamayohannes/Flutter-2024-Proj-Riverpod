import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/login_admin_provider.dart';

class AdminLoginPage extends ConsumerWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void _login() {
      final username = _usernameController.text;
      final password = _passwordController.text;
      ref.read(loginProvider.notifier).login(username, password);
      if (ref.read(loginProvider)) {
        context.go('/admin_page');
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                  buttonText: 'Login',
                  buttonColor: Colors.green.shade800,
                  buttonTextColor: Colors.white,
                  buttonAction: _login)
            ],
          ),
        ),
      ),
    );
  }
}
