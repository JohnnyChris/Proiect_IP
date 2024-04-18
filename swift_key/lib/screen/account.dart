import 'package:flutter/material.dart';
import 'package:swift_key/Menu/navbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to the Account Page!'),
      ),
      // Include the custom bottom nav bar
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
