// auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:glorify/views/home/home_screen.dart';
import 'package:glorify/views/login/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:glorify/auth/notifiers/auth_notifier.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null && user.emailVerified) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) =>
          const Scaffold(body: Center(child: Text('An error occurred'))),
    );
  }
}
