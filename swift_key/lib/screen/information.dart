import 'package:flutter/material.dart';
import 'package:swift_key/screen/customnavbar.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String profileImagePath = 'assets/avatar.png'; // Profile image path
  int selectedIndex = 0; // Selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomNavBar(
          title: "Information",
          onBackButtonPressed: () {
            Navigator.of(context)
                .pop(); // Navigate back when the back button is pressed
          },
          profileImagePath: 'assets/avatar.png',
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Image.asset(
                'assets/SwiftkeyA.png', // Replace with your image asset path
                // Adjust height as needed
              ),
              Text(
                'SwiftKey Access is an app developed by Echipa Petarda SRL. This app is still a prototype, so please report any bugs and we will do our best to solve them as soon as posible.\n\nAll rights reserved by\nEchipa Petarda SRL.',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ));
  }
}
