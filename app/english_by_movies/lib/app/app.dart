import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:english_by_movies/features/vocabulary/presentation/pages/vocab_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(debugShowCheckedModeBanner: false, home: VocabPage()),
    );
  }
}
