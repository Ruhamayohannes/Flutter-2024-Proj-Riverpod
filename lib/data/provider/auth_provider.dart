import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to manage authentication state
final authProvider = StateProvider<bool>((ref) => false);

// Function to simulate user sign-in
void signIn(WidgetRef ref) {
  ref.read(authProvider.notifier).state = true;
}

// Function to simulate user sign-out
void signOut(WidgetRef ref) {
  ref.read(authProvider.notifier).state = false;
}
