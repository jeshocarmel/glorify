import 'package:flutter/material.dart';
import 'package:glorify/common/providers/language_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageProvider);

    return DropdownButton<Locale>(
      value: currentLocale,
      items: const [
        DropdownMenuItem(value: Locale('en', ''), child: Text('English')),
        DropdownMenuItem(value: Locale('de', ''), child: Text('Deutsch')),
        DropdownMenuItem(value: Locale('ta', ''), child: Text('தமிழ்')),
      ],
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          ref.read(languageProvider.notifier).state = newLocale;
        }
      },
      dropdownColor: Theme.of(context).primaryColor, // Match AppBar color
      style: TextStyle(
          color: const Color.fromARGB(
              255, 54, 31, 31)), // Text color for dropdown items
    );
  }
}
