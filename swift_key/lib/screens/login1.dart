import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/constants/colors.dart';
import 'package:swift_key/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key? key}) : super(key: key);

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;

  // Function to decode JWT token and extract user details
  Map<String, dynamic> _decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = base64Url.decode(base64Url.normalize(parts[1]));
    final Map<String, dynamic> decodedPayload = json.decode(utf8.decode(payload));
    return decodedPayload;
  }

  // Login function
  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    print('Username: $username');
    print('Password: $password');

    final response = await http.post(
      Uri.parse('http://192.168.1.140:8000/auth/token'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'username': username,
        'password': password,
      },
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final accessToken = responseData['access_token'];

      print('Access Token: $accessToken');

      // Decode the JWT token to get user details
      final userDetails = _decodeJWT(accessToken);

      // Store user details in global variables
      globals.globalUsername = userDetails['sub'] ?? '';
      globals.globalUserId = userDetails['id'] ?? 0;
      globals.globalIdAngajat = userDetails['ID_Angajat'] != null ? int.tryParse(userDetails['ID_Angajat'].toString()) ?? 0 : 0;
      globals.globalFirstName = userDetails['Nume'] ?? '';
      globals.globalLastName = userDetails['Prenume'] ?? '';
      globals.globalCNP = userDetails['CNP'] ?? '';
      globals.globalEmail = userDetails['NumarLegitimatie'] ?? '';
      globals.globalDepartment = userDetails['Divizia'] ?? '';
      globals.globalAccessLevel = userDetails['IntervaleAcces'] != null ? int.tryParse(userDetails['IntervaleAcces'].toString()) ?? 0 : 0;
      globals.globalPhoneNumber = userDetails['CodSecuritateBluetooth'] ?? '';
      globals.globalCarPlate = userDetails['NumarMasina'] ?? '';
      globals.globalAccesAuto = userDetails['AccesAuto'] ?? '';

      print('User Details:');
      print('Username: ${globals.globalUsername}');
      print('User ID: ${globals.globalUserId}');
      print('ID Angajat: ${globals.globalIdAngajat}');
      print('First Name: ${globals.globalFirstName}');
      print('Last Name: ${globals.globalLastName}');
      print('CNP: ${globals.globalCNP}');
      print('Email: ${globals.globalEmail}');
      print('Department: ${globals.globalDepartment}');
      print('Access Level: ${globals.globalAccessLevel}');
      print('Phone Number: ${globals.globalPhoneNumber}');
      print('Car Plate: ${globals.globalCarPlate}');
      print('Access Auto: ${globals.globalAccesAuto}');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 56,
            left: 24,
            bottom: 24,
            right: 24,
          ),
          child: IndexedStack(
            alignment: Alignment.center,
            index: isLoading ? 0 : 1,
            children: [
              const CircularProgressIndicator(
                color: Colors.blue,
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/SwiftkeyA.png",
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Welcome back,",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(LineAwesomeIcons.user_astronaut),
                              labelText: "Username",
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _login();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
