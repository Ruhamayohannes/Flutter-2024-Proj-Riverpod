import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import '../../application/providers/login_user_provider.dart';

class LoginUser extends ConsumerWidget {
  const LoginUser({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final password = ref.watch(passwordProvider);
    final loginStatus = ref.watch(loginStatusProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Image.asset(
                  'assets/images/sebawilogo.png',
                  width: 140.0,
                  height: 140.0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 35),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      'Welcome back.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextFormField(
                labelText: 'Username',
                onChanged: (value) =>
                    ref.read(usernameProvider.notifier).state = value,
              ),
              const SizedBox(height: 10.0),
              CustomTextFormField(
                labelText: 'Password',
                obscureText: true,
                onChanged: (value) =>
                    ref.read(passwordProvider.notifier).state = value,
              ),
              const SizedBox(height: 40.0),
              CustomButton(
                buttonText: 'Login',
                buttonColor: const Color.fromARGB(255, 83, 171, 71),
                buttonTextColor: Colors.white,
                buttonAction: () async {
                  final loginSuccessful = await ref
                      .read(loginStatusProvider.notifier)
                      .login(username, password);
                  if (!loginSuccessful) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Login Failed'),
                        content: const Text(
                            'Username and password cannot be empty.'),
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
                  } else {
                    context.go('/user_home');
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child: Text('No account?'),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/signup');
                        },
                        child: const Text(
                          'Signup',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 66, 148, 69),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
