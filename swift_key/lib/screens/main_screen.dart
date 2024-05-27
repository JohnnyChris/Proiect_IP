import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_key/constants/colors.dart';
import 'package:swift_key/screens/login1.dart';
import 'package:swift_key/widgets/navbar.dart';
import 'package:swift_key/screens/account.dart';
import 'package:swift_key/screens/home.dart';

import 'access.dart';

final bottomNavigatorIndex = StateProvider<int>((ref) => 1);

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to Logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen1(),
                  ),
                  (Route route) => false,
                ),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget getFragment(int index) {
    switch (index) {
      case 0:
        return const AccessScreen();
      case 1:
        return const HomeScreen();
      case 2:
        return const AccountScreen();
    }
    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          _onWillPop();
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: getFragment(ref.watch(bottomNavigatorIndex)),
          bottomNavigationBar: const CustomBottomNavBar(),
        ));
  }
}
