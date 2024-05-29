import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_key/widgets/customnavbar2.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';

class AccessScreen extends StatefulWidget {
  const AccessScreen({Key? key}) : super(key: key);

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  String profileImagePath = 'assets/avatar.png'; // Profile image path
  BluetoothConnection? connection;
  bool isConnected = false;
  String hc05Address =
      "00:22:09:01:16:57"; // Replace with your HC-05 MAC address

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
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(hc05Address);
      setState(() {
        isConnected = true;
        this.connection = connection;
      });
      print('Connected to the device');
    } catch (e) {
      print('Cannot connect, exception occurred: $e');
    }
  }

  void _sendCommand(String command) {
    if (isConnected && connection != null) {
      connection!.output.add(Uint8List.fromList(utf8.encode(command)));
      print('Sent command: $command');

      if (command == 'alin') {
        globals.schedules.add({
          "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "clockin": DateFormat('HH:mm').format(DateTime.now())
        });
      } else if (command == '0') {
        Map<String, dynamic> lastItem = globals.schedules.last;
        globals.schedules.removeLast();
        globals.schedules.add({
          "date": lastItem["date"],
          "clockin": lastItem["clockin"],
          "clockout": DateFormat('HH:mm').format(DateTime.now())
        });
      }
    }
    // Handle other commands
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar2(
        title: "Access Page",
        profileImagePath: 'assets/avatar.png',
      ),
      //automaticallyImplyLeading: false, // Remove back arrow button
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
                  onPressed: () => _sendCommand('alin'),
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
                  onPressed: () =>
                      _sendCommand('C'), // Command to open car gate
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
                  onPressed: () =>
                      _sendCommand('0'), // Command to end work time
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
