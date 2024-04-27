import 'package:flutter/material.dart';
//import 'package:swift_key/Menu/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _PageState();
}

class _PageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Welcome to the Home Page!'),
    );
  }
}
