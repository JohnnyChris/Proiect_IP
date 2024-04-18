import 'package:flutter/material.dart';
import 'package:swift_key/Menu/navbar.dart';

class AccessScreen extends StatefulWidget {
  const AccessScreen({super.key});

  @override
  State<AccessScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<AccessScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to the Access Page!'),
      ),
      // Include the custom bottom nav bar
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
