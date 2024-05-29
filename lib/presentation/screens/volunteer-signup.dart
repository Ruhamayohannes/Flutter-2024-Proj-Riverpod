import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/volunteer_signup_provider.dart';

class VolunteerSignup extends ConsumerWidget {
  const VolunteerSignup({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNotifier = ref.watch(volunteerSignupProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: SingleChildScrollView(
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
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 2.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Do something good today.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: signupNotifier.fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    errorText: signupNotifier.fullNameError,
                  ),
                  onChanged: (value) => signupNotifier.setFullName(value),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: signupNotifier.emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    errorText: signupNotifier.emailError,
                  ),
                  onChanged: (value) => signupNotifier.setEmail(value),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: signupNotifier.usernameController,
                  decoration: InputDecoration(
                    labelText: 'Create Username',
                    errorText: signupNotifier.usernameError,
                  ),
                  onChanged: (value) => signupNotifier.setUsername(value),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: signupNotifier.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Create Password',
                    errorText: signupNotifier.passwordError,
                  ),
                  onChanged: (value) => signupNotifier.setPassword(value),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: signupNotifier.confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    errorText: signupNotifier.confirmPasswordError,
                  ),
                  onChanged: (value) =>
                      signupNotifier.setConfirmPassword(value),
                  obscureText: true,
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () => signupNotifier.signUp(context),
                  style: ElevatedButton.styleFrom(),
                  child: Text('Signup'),
                ),
                Padding(
                  padding: const EdgeInsets.all(17),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Text('Already signed up?'),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go('/user_login');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 66, 148, 69),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
