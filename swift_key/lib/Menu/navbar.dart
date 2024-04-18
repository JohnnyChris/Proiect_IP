import 'package:flutter/material.dart';
import 'package:swift_key/screen/account.dart';
//import 'package:swift_key/screen/home.dart';
import 'package:swift_key/screen/page.dart';
import 'package:swift_key/screen/access.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lock),
          label: 'Access',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.red,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageScreen()),
            );

            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccessScreen()),
            );

            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
            break;
        }
      },
    );
  }
}
