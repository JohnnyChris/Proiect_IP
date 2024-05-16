import 'package:flutter/material.dart';
import 'package:swift_key/screen/customnavbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String profileImagePath = 'assets/avatar.png'; // Profile image path
  int selectedIndex = 0; // Selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: "",
        onBackButtonPressed: () {},
        profileImagePath: profileImagePath,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            const Text(
              "Buna Alin,",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index; // Update selected index
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    color: selectedIndex == index ? Colors.black : Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        profileImagePath,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
