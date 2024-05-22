import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/screen/customnavbar2.dart';
import 'package:swift_key/screen/home.dart';
import 'package:swift_key/screen/main_screen.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "First Name",
                value: "Alin-Jonathan",
                onPressed: () {},
                icon: LineAwesomeIcons.user_astronaut,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Last Name",
                value: "Rogojan",
                onPressed: () {},
                icon: LineAwesomeIcons.user_1,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "CNP",
                value: "5030128303941",
                onPressed: () {},
                icon: LineAwesomeIcons.identification_badge,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Badge ID",
                value: "#123456",
                onPressed: () {},
                icon: LineAwesomeIcons.identification_card,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "E-mail",
                value: "alin.rogojan@student.upt.ro",
                onPressed: () {},
                icon: LineAwesomeIcons.mail_bulk,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Phone nr",
                value: "0720686200",
                onPressed: () {},
                icon: LineAwesomeIcons.mobile_phone,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Departament",
                value: "Fundraising",
                onPressed: () {},
                icon: LineAwesomeIcons.damaged_house,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Car plate",
                value: "SM98RJR",
                onPressed: () {},
                icon: LineAwesomeIcons.caret_square_down,
              ),
              const SizedBox(height: 12),
              AccountDetailsWidget(
                title: "Access level",
                value: "Auto",
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
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    required this.icon,
  });

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
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
