// auth_notifier.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:glorify/auth/backend/auth_service.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null) {
    _authStateChanges();
  }

  final AuthService _authService = AuthService();

  void _authStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      state = user;
    });
  }

  Future<void> signUp(String email, String password) async {
    await _authService.signUpWithEmailPassword(email, password);
    state = FirebaseAuth.instance.currentUser;
  }

  Future<void> signIn(String email, String password) async {
    await _authService.signInWithEmailPassword(email, password);
    state = FirebaseAuth.instance.currentUser;
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
    state = FirebaseAuth.instance.currentUser;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = null;
  }

  bool isEmailVerified() {
    return _authService.isEmailVerified();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
