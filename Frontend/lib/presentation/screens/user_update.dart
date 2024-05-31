import 'package:flutter/material.dart';
import 'package:Sebawi/presentation/widgets/profile_update_form.dart';

class UserUpdate extends StatelessWidget {
  const UserUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProfileUpdateForm(),
      ),
    );
  }
}
