import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app/view/landing/landing.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  static String userVarient = "paid";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Go Task",
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Landing()),
    );
  }
}
