import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/widgets/customnavbar2.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => AccountDetailsScreenState();
}

class AccountDetailsScreenState extends State<AccountDetailsScreen> {
  Map<String, dynamic>? accountDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAccountDetails();
  }

  Future<void> fetchAccountDetails() async {
    setState(() {
      isLoading = true;
    });

    final angajatiId = '10'; // Replace '1' with the actual ID as a string
    final response = await http.get(
      Uri.parse('http://192.168.1.8:8000/ang/Angajati/$angajatiId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        accountDetails = json.decode(response.body);
        print("Response data: $accountDetails"); // Debug print
      } catch (e) {
        print("Error parsing response: $e");
        accountDetails = null;
      }
    } else {
      print("Failed to load data: ${response.statusCode}");
      print("Response body: ${response.body}");
      accountDetails = null;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar2(
        title: "Account Details",
        profileImagePath: 'assets/avatar.png',
        backButton: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : accountDetails == null
              ? Center(child: Text('Error loading account details'))
              : SingleChildScrollView(
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
                          title: "ID_Angajat",
                          value: accountDetails!['ID_Angajat'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.identification_card,
                        ),
                        AccountDetailsWidget(
                          title: "ID Utilizator",
                          value: accountDetails!['ID_Utilizator'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.identification_card,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "First Name",
                          value: accountDetails!['Nume'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.user_astronaut,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "Last Name",
                          value: accountDetails!['Prenume'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.user_1,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "CNP",
                          value: accountDetails!['CNP'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.identification_badge,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "Nr Legitimatie",
                          value: accountDetails!['NumarLegitimatie'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.sim_card,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "Access Intervals",
                          value: accountDetails!['IntervaleAccess'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.clock,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "Divizie",
                          value: accountDetails!['Divizia'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.damaged_house,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "Bluetooth code",
                          value: accountDetails!['CodSecuritateBluetooth']
                              .toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.bluetooth,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "Car plate",
                          value: accountDetails!['NumarMasina'].toString(),
                          onPressed: () {},
                          icon: LineAwesomeIcons.caret_square_down,
                        ),
                        const SizedBox(height: 12),
                        AccountDetailsWidget(
                          title: "AccesAuto",
                          value: accountDetails!['AccesAuto'].toString(),
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
