import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/application/providers/user_update_provider.dart';

class ProfileUpdateForm extends ConsumerWidget {
  const ProfileUpdateForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String username = '';
    String email = '';
    String password = '';
    String confirmPassword = '';

    void showDeleteConfirmationDialog(BuildContext context) {
      // Dialog implementation remains the same
    }

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 78, 33),
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
            ),
            onSaved: (value) => name = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Username'),
            onSaved: (value) => username = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => email = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (value) => password = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            onChanged: (value) => confirmPassword = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != password) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            buttonText: 'Update Profile',
            buttonColor: Colors.green,
            buttonTextColor: Colors.white,
            buttonAction: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                const userId = '6668170b05e8c3d981fde84e'; // Replace with actual user ID
                final result = await ref.read(userProfileUpdateProvider.notifier).updateProfile(
                  context,
                  userId,
                );
                // if (result == null) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Profile updated successfully')),
                //   );
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(result)),
                //   );
                // }
              }
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              showDeleteConfirmationDialog(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // Text color
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
