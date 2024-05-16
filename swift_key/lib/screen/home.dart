import 'package:flutter/material.dart';
import 'package:swift_key/screen/customnavbar2.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:swift_key/screen/schedule.dart';

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

    // Navigate to the SchedulePage when a day is selected
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar2(
        title: "",
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
                      width: 65, // Fixed width for the square
                      height: 80, // Fixed height for the square
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/human.png',
                            height: 50,
                            width: 40,
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
                              fontSize: 10,
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
