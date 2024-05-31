import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginUserState {
  final String username;
  final String password;
  final String? usernameError;
  final String? passwordError;
  final bool isLoading;
  final bool isLoggedIn;

  LoginUserState({
    required this.username,
    required this.password,
    this.usernameError,
    this.passwordError,
    this.isLoading = false,
    this.isLoggedIn = false,
  });

  LoginUserState copyWith({
    String? username,
    String? password,
    String? usernameError,
    String? passwordError,
    bool? isLoading,
    bool? isLoggedIn,
  }) {
    return LoginUserState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameError: usernameError,
      passwordError: passwordError,
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class LoginUserNotifier extends StateNotifier<LoginUserState> {
  LoginUserNotifier() : super(LoginUserState(username: '', password: ''));

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> login() async {
    // Validate inputs
    if (state.username.isEmpty) {
      state = state.copyWith(usernameError: 'Username cannot be empty');
    } else {
      state = state.copyWith(usernameError: null);
    }

    if (state.password.isEmpty) {
      state = state.copyWith(passwordError: 'Password cannot be empty');
    } else {
      state = state.copyWith(passwordError: null);
    }

    if (state.username.isNotEmpty && state.password.isNotEmpty) {
      state = state.copyWith(isLoading: true);
      await Future.delayed(
          const Duration(seconds: 2)); // Simulate a network call

      // Simulate login logic
      if (state.username == 'admin' && state.password == 'password') {
        state = state.copyWith(isLoggedIn: true, isLoading: false);
      } else {
        state = state.copyWith(
            isLoggedIn: false,
            isLoading: false,
            passwordError: 'Invalid credentials');
      }
    }
  }
}
