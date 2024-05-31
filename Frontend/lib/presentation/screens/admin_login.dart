import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/login_admin_provider.dart';
import '../../application/providers/login_user_provider.dart';

class AdminLoginPage extends ConsumerWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminLoginNotifier = ref.watch(adminLoginProvider);

    void _login() async {
      await ref.read(adminLoginProvider).login(context);
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
                controller: adminLoginNotifier.usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                  errorText: adminLoginNotifier.usernameError,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: adminLoginNotifier.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  errorText: adminLoginNotifier.passwordError,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                buttonText: 'Login',
                buttonColor: Colors.green.shade800,
                buttonTextColor: Colors.white,
                buttonAction: _login,
              ),
              if (adminLoginNotifier.loginError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      adminLoginNotifier.loginError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
