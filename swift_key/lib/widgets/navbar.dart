import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_key/constants/colors.dart';
import 'package:swift_key/screens/main_screen.dart';

class CustomBottomNavBar extends ConsumerStatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  ConsumerState<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends ConsumerState<CustomBottomNavBar> {
  late int _selectedIndex;

  void _onItemTapped(int index) {
    ref.read(bottomNavigatorIndex.notifier).update((state) => index);
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = ref.watch(bottomNavigatorIndex);

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'Access',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.blue,
        onTap: _onItemTapped);
  }
}
