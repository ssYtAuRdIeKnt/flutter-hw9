import 'package:flutter/material.dart';
import 'package:hw3_app/screens/users_screen.dart';

void main() => runApp(const Project8App());

class Project8App extends StatelessWidget {
  const Project8App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsersScreen(),
    );
  }
}
