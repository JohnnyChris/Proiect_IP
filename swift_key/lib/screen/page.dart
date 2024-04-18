import 'package:flutter/material.dart';
import 'package:swift_key/Menu/navbar.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageState();
}

class _PageState extends State<PageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to the Page Page!'),
      ),
      // Include the custom bottom nav bar
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
    );
  }
}
