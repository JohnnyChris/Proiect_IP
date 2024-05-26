import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_key/constants/colors.dart';
import 'package:swift_key/screens/main_screen.dart';

class CustomNavBar2 extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final String? profileImagePath;
  final bool backButton;

  CustomNavBar2({
    required this.title,
    this.profileImagePath,
    this.backButton = false,
  });

  @override
  ConsumerState<CustomNavBar2> createState() => _CustomNavBar2State();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomNavBar2State extends ConsumerState<CustomNavBar2> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(color: AppColors.black),
      ),
      automaticallyImplyLeading: widget.backButton,
      actions: [
        if (widget.profileImagePath != null) ...[
          GestureDetector(
            onTap: () {
              ref.read(bottomNavigatorIndex.notifier).update((state) => 2);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage(widget.profileImagePath!),
              radius: 20,
            ),
          ),
        ],
        SizedBox(width: 16),
      ],
      //backgroundColor: Colors.blue, // Customize the background color as needed
    );
  }
}
