import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/widgets/customnavbar2.dart';
import 'globals.dart' as globals;

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AccountDetailsScreen> createState() => AccountDetailsScreenState();
}

class AccountDetailsScreenState extends State<AccountDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar2(
        title: "Account Details",
        profileImagePath: 'assets/avatar.png',
        backButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
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
                    TextButton(
                      onPressed: () {},
                      child: const Text("Change picture"),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Text(
                "Profile information",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "First Name",
                value: globals.globalFirstName,
                onPressed: () {},
                icon: LineAwesomeIcons.user_astronaut,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Last Name",
                value: globals.globalLastName,
                onPressed: () {},
                icon: LineAwesomeIcons.user_1,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "CNP",
                value: globals.globalCNP,
                onPressed: () {},
                icon: LineAwesomeIcons.identification_badge,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Badge ID",
                value: "#123456", // Update this with the corresponding global variable
                onPressed: () {},
                icon: LineAwesomeIcons.identification_card,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "E-mail",
                value: globals.globalEmail.toString(),
                onPressed: () {},
                icon: LineAwesomeIcons.mail_bulk,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Phone nr",
                value: globals.globalPhoneNumber,
                onPressed: () {},
                icon: LineAwesomeIcons.mobile_phone,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Departament",
                value: globals.globalDepartment,
                onPressed: () {},
                icon: LineAwesomeIcons.damaged_house,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Car plate",
                value: globals.globalCarPlate,
                onPressed: () {},
                icon: LineAwesomeIcons.caret_square_down,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Access level",
                value: globals.globalAccessLevel.toString(),
                onPressed: () {},
                icon: LineAwesomeIcons.car,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountDetailsWidget extends StatelessWidget {
  const AccountDetailsWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 6),
        Expanded(
          flex: 5,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 10,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
