import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/widgets/customnavbar2.dart';
import 'package:swift_key/screens/home.dart';
import 'package:swift_key/screens/main_screen.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

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
      "90:9A:77:38:07:B4"; // Replace with your HC-05 MAC address

  @override
  void initState() {
    super.initState();
    _connectToBluetooth();
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
    }
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
                  onPressed: () => _sendCommand('N'),
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
                      _sendCommand('E'), // Command to end work time
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
