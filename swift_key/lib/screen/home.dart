import 'package:flutter/material.dart';
import 'package:swift_key/screen/customnavbar.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String profileImagePath = 'assets/avatar.png'; // Profile image path
  int selectedIndex = 0; // Selected index
  DateTime today = DateTime.now();

  // List of texts for each button
  final List<String> buttonLabels = ["Developer", "HR", "Tester", "Production"];

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: "",
        onBackButtonPressed: () {},
        profileImagePath: profileImagePath,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
        child: Column(
          children: [
            const Text(
              "Buna Alin,",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                buttonLabels.length,
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
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/human.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            buttonLabels[index], // Use the text from the list
                            style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              child: TableCalendar(
                rowHeight: 43,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 10, 16),
                onDaySelected: _onDaySelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
