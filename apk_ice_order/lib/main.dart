import 'package:flutter/material.dart';
import 'screens/auth/login_page.dart';

void main() {
  runApp(const EsBatuApp());
}

class EsBatuApp extends StatelessWidget {
  const EsBatuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Es Batu Kristal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFFB3E5E5),
      ),
      home: const LoginPage(),
    );
  }
}
