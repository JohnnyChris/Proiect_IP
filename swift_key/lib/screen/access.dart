import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/screen/customnavbar2.dart';
import 'package:swift_key/screen/home.dart';
import 'package:swift_key/screen/main_screen.dart';

class AccessScreen extends StatefulWidget {
  const AccessScreen({Key? key});

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  String profileImagePath = 'assets/avatar.png'; // Profile image path
  int selectedIndex = 0; // Selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar2(
        title: "Access Page", profileImagePath: 'assets/avatar.png',

        //automaticallyImplyLeading: false, // Remove back arrow button
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              const Text(
                'Select your option',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 240,
                height: 120,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/human.png', // Replace with your image asset path
                        width: 40, // Adjust width as needed
                        height: 40, // Adjust height as needed
                      ),
                      SizedBox(width: 10),
                      Text('Open Gate'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 240,
                height: 120,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/car3.png', // Replace with your image asset path
                        width: 40, // Adjust width as needed
                        height: 40, // Adjust height as needed
                      ),
                      SizedBox(width: 10),
                      Text('Open Car Gate'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 240,
                height: 120,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/clock.png', // Replace with your image asset path
                        width: 40, // Adjust width as needed
                        height: 40, // Adjust height as needed
                      ),
                      SizedBox(width: 10),
                      Text('End Work Time'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
