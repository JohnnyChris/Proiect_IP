import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_key/constants/colors.dart';
import 'package:swift_key/screens/main_screen.dart';
import 'package:swift_key/screens/signup.dart';
import 'package:http/http.dart' as http;

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key? key}) : super(key: key);

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

//login
  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://192.168.1.10:8000/auth/token'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful login, e.g., store token, navigate to another page
      final responseData = json.decode(response.body);
      final accessToken = responseData['access_token'];
      print('Access Token: $accessToken');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      // Handle login failure
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
          child: Column(
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
                      //email
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Username",
                        ),
                      ),
                      const SizedBox(height: 16),

                      //password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
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
                      const SizedBox(height: 8),

                      //forgot password button
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

                      //sign in button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _login();
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

                      //create account button
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
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
        ),
      ),
    );
  }
}
