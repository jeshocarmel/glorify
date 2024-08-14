import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glorify/auth/backend/auth_wrapper.dart';
import 'package:glorify/common/providers/language_provider.dart';
import 'package:glorify/views/home/home_screen.dart';
import 'package:glorify/views/login/forgot_password.dart';
import 'package:glorify/views/login/login_screen.dart';
import 'package:glorify/views/login/signup_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageProvider);
    return MaterialApp(
      locale: currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Firebase Auth',
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
