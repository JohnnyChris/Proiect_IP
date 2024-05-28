import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/constants/colors.dart';
import 'package:swift_key/screens/account_details.dart';
import 'package:swift_key/screens/globals.dart';
import 'package:swift_key/widgets/customnavbar2.dart';
import 'package:swift_key/screens/editprofile.dart';
import 'package:swift_key/screens/information.dart';
import 'package:swift_key/screens/login1.dart';
import 'package:swift_key/screens/schedule.dart';
import 'package:swift_key/screens/settings.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar2(
        title: "My Account",
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/avatar.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //nume
                Text(globalUsername,
                    style: Theme.of(context).textTheme.headlineMedium),

                //username
                Text(globalCNP, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 10),

                //edit profile button
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        side: BorderSide.none,
                        shape: StadiumBorder()),
                    child: const Text(
                      "Edit profile",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //menu
                //settings
                ProfileMenuWidget(
                    title: "Settings",
                    icon: LineAwesomeIcons.cog,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                      );
                    }),

                //account details
                ProfileMenuWidget(
                    title: "Account Details",
                    icon: LineAwesomeIcons.user_astronaut,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountDetailsScreen()),
                      );
                    }),

                //schedule
                ProfileMenuWidget(
                    title: "Schedule",
                    icon: LineAwesomeIcons.calendar,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScheduleScreen()),
                      );
                    }),

                //information
                ProfileMenuWidget(
                    title: "Information",
                    icon: LineAwesomeIcons.info,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InfoScreen()),
                      );
                    }),

                //logout button
                ProfileMenuWidget(
                    title: "Logout",
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor: AppColors.red,
                    endIcon: false,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen1(),
                        ),
                        (Route route) => false,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.lightBlue,
        ),
        child: Icon(icon, color: AppColors.blue),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.lightGrey),
              child: const Icon(LineAwesomeIcons.angle_right,
                  color: AppColors.grey),
            )
          : null,
    );
  }
}
