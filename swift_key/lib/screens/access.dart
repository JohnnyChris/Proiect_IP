import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_key/widgets/customnavbar2.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class AccessScreen extends StatefulWidget {
  const AccessScreen({Key? key}) : super(key: key);

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  String profileImagePath = 'assets/avatar.png'; // Profile image path
  BluetoothConnection? connection;
  bool isConnected = false;
  String hc05Address = "00:22:09:01:16:57"; // Replace with your HC-05 MAC address

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted &&
        await Permission.bluetooth.request().isGranted &&
        await Permission.location.request().isGranted) {
      _connectToBluetooth();
    } else {
      print('Permissions not granted');
    }
  }

  void _connectToBluetooth() async {
    try {
      // Attempt to connect to the HC-05 device
      BluetoothConnection connection = await BluetoothConnection.toAddress(hc05Address);
      setState(() {
        isConnected = true;
        this.connection = connection;
      });
      print('Connected to the device');
    } catch (e) {
      print('Cannot connect, exception occurred: $e');
    }
  }

  void _disconnectFromBluetooth() async {
    if (isConnected && connection != null) {
      await connection!.close();
      setState(() {
        isConnected = false;
        connection = null;
      });
      print('Disconnected from the device');
    }
  }

  Future<void> _sendCommand(int command) async {
    if (isConnected && connection != null) {
      connection!.output.add(Uint8List.fromList(utf8.encode(command.toString() + "\n")));
      await connection!.output.allSent; // Ensure all data is sent
      print('Sent command: $command');

      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String currentTime = DateFormat('HH:mm').format(DateTime.now());

      if (command == globals.globalIdAngajat) {
        // Add the schedule to the globals
        globals.schedules.add({
          "date": currentDate,
          "clockin": currentTime,
          "clockout": "", // Initialize clockout as empty string
        });
      } else if (command == 0) {
        if (globals.schedules.isNotEmpty) {
          Map<String, dynamic> lastItem = globals.schedules.last;
          globals.schedules.removeLast();
          globals.schedules.add({
            "date": lastItem["date"],
            "clockin": lastItem["clockin"],
            "clockout": currentTime,
          });

          // Prepare data to send to the FastAPI endpoint
          Map<String, dynamic> data = {
            "ID_Inregistrare": 0,
            "username": globals.globalUsername,
            "ID_Angajat": globals.globalIdAngajat,
            "DataIntrare": lastItem["date"],
            "OraIntrare": lastItem["clockin"],
            "OraIesire": currentTime,
          };

          // Send POST request to FastAPI
          var url = Uri.parse('http://192.168.1.140:8000/reg/');
          var response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data),
          );

          if (response.statusCode == 201) {
            print('Data successfully sent to FastAPI');
          } else {
            print('Failed to send data to FastAPI: ${response.body}');
          }
        } else {
          print('No clock-in data found for clock-out');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar2(
        title: "Access Page",
        profileImagePath: 'assets/avatar.png',
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              const Text(
                'Select your option',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 240,
                height: 120,
                child: ElevatedButton(
                  onPressed: () => _sendCommand(2), // Command to open the gate
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
              const SizedBox(height: 30),
              SizedBox(
                width: 240,
                height: 120,
                child: ElevatedButton(
                  onPressed: () => _sendCommand(globals.globalIdAngajat), // Command to open car gate
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
              const SizedBox(height: 30),
              SizedBox(
                width: 240,
                height: 120,
                child: ElevatedButton(
                  onPressed: () => _sendCommand(0), // Command to end work time
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

  @override
  void dispose() {
    connection?.dispose();
    connection = null;
    super.dispose();
  }
}
