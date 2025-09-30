import 'package:flutter/material.dart';
import 'languageTranslator.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Language Translate",
      debugShowCheckedModeBanner: false,
      home: Languagetranslator(),
    );
  }
}
