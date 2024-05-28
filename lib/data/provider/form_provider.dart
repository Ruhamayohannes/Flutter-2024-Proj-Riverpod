import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for email input
final emailProvider = StateProvider<String>((ref) => '');

// Provider for password input
final passwordProvider = StateProvider<String>((ref) => '');
