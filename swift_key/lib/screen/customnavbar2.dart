import 'package:flutter/material.dart';

class CustomNavBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String profileImagePath;

  CustomNavBar2({
    required this.title,
    required this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      automaticallyImplyLeading: false, // Remove the back arrow
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
