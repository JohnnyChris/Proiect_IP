import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/constants/colors.dart';
import 'package:swift_key/widgets/customnavbar2.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = true;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar2(
        title: "Settings",
        backButton: true,
        profileImagePath: 'assets/avatar.png',
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 12),
            const Row(
              children: [
                // Icon(
                //   LineAwesomeIcons.cog,
                //   color: Colors.blue,
                // ),
                SizedBox(
                  height: 40,
                  width: 10,
                ),
                Text(
                  "Account settings",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SettingsWidget(
              title: "Notifications",
              value: valNotify1,
              onChanged: onChangeFunction1,
            ),
            SettingsWidget(
              title: "Dark Theme",
              value: valNotify2,
              onChanged: onChangeFunction2,
            ),
            SettingsWidget(
              title: "Silent",
              value: valNotify3,
              onChanged: onChangeFunction3,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
    required this.onChanged,
    required this.title,
    required this.value,
  });

  final ValueChanged<bool> onChanged;
  final String title;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: AppColors.blue,
              trackColor: AppColors.grey,
              value: value,
              onChanged: onChanged,
            ),
          )
        ],
      ),
    );
  }
}
