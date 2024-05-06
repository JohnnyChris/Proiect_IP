import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:swift_key/screen/login.dart';
import 'package:swift_key/screen/login1.dart';
//import 'package:swift_key/screen/main_screen.dart';
//import 'package:swift_key/screen/login.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginScreen1(),
    );
  }
}
