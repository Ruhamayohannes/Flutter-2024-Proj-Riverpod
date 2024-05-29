import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/application/providers/profile_update_provider.dart';  

class ProfileUpdateForm extends ConsumerStatefulWidget {
  @override
  _ProfileUpdateFormState createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends ConsumerState<ProfileUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 78, 33),
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
            ),
            onSaved: (value) => _name = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            onSaved: (value) => _username = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => _email = value!,
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
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onSaved: (value) => _password = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            onSaved: (value) => _confirmPassword = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _password) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            buttonText: 'Update Profile',
            buttonColor: Colors.green,
            buttonTextColor: Colors.white,
            buttonAction: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(profileProvider.notifier).updateProfile(
                  username: _username,
                  password: _password,
                  email: _email,
                  name: _name,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile updated')),
                );
              }
            },
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              ref.read(profileProvider.notifier).deleteAccount();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // Text color
            ),
            child: Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
