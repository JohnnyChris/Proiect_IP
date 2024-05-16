import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackButtonPressed;
  final String profileImagePath;

  CustomNavBar({
    required this.title,
    required this.onBackButtonPressed,
    required this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onBackButtonPressed,
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(profileImagePath),
          radius: 20,
        ),
        SizedBox(width: 16),
      ],
      //backgroundColor: Colors.blue, // Customize the background color as needed
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Usage Example
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Your Title',
        onBackButtonPressed: () {
          Navigator.of(context)
              .pop(); // Navigate back when the back button is pressed
        },
        profileImagePath: 'assets/avatar.png',
      ),
      body: Center(
        child: Text('Your content here'),
      ),
    );
  }
}
