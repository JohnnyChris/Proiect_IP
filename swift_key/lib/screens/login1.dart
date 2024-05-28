import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_key/constants/colors.dart';
import 'package:swift_key/screens/main_screen.dart';
import 'package:swift_key/screens/signup.dart';
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

    final response = await http.post(
      Uri.parse('http://192.168.87.137:8000/auth/token'),
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

      // Decode the JWT token to get user details
      final userDetails = _decodeJWT(accessToken);

      // Store user details in global variables
      globals.globalUsername = userDetails['sub'];
      globals.globalUserId = userDetails['id'];
      globals.globalFirstName = userDetails['Nume'];
      globals.globalLastName = userDetails['Prenume'];
      globals.globalCNP = userDetails['CNP'];
      globals.globalEmail = userDetails['NumarLegitimatie'];
      globals.globalDepartment = userDetails['Divizia'];
      globals.globalAccessLevel = int.tryParse(userDetails['IntervaleAcces']) ?? 0;
      globals.globalPhoneNumber = userDetails['CodSecuritateBluetooth'];
      globals.globalCarPlate = userDetails['NumarMasina'];

      

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
                              prefixIcon: Icon(Icons.email),
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
                                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                // Implement forgot password functionality here
                              },
                              child: const Text(
                                "Forgot password",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
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
                          SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                );
                              },
                              child: const Text(
                                "Create account",
                                style: TextStyle(
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
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
