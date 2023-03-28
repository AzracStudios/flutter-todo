import 'package:flutter/material.dart';
import 'landing.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Go Task",
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Landing()),
    );
  }
}
