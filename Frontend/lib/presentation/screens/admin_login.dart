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
    final loginNotifier = ref.watch(loginProvider);
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
              TextFormField(
                controller: loginNotifier.usernameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 4.0),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 31, 78, 33),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(213, 213, 213, 1),
                    ),
                  ),
                  labelText: 'Username',
                  errorText: loginNotifier.usernameError,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 165, 165, 165),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onChanged: loginNotifier.setUsername,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: loginNotifier.passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 4.0),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 31, 78, 33),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(213, 213, 213, 1),
                    ),
                  ),
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 165, 165, 165),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  labelText: 'Password',
                  errorText: loginNotifier.passwordError,
                ),
                obscureText: true,
                onChanged: loginNotifier.setPassword,
              ),
              const SizedBox(height: 40),
              CustomButton(
                buttonText: 'Login',
                buttonColor: Colors.green.shade800,
                buttonTextColor: Colors.white,
                buttonAction: () => loginNotifier.login(context),
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
