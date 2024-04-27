import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_key/screen/home.dart';
import 'package:swift_key/screen/login.dart';
import 'package:swift_key/screen/login1.dart';
import 'package:swift_key/screen/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text("Let's create your account",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),

              //Form
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        //first name box
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                                labelText: "First Name",
                                prefixIcon: Icon(Iconsax.user)),
                          ),
                        ),
                        const SizedBox(width: 16),

                        //last name box
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                                labelText: "Last Name",
                                prefixIcon: Icon(Iconsax.user)),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),

                    //username box
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Iconsax.user_edit)),
                    ),
                    const SizedBox(height: 16),

                    //email box
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: "E-mail",
                          prefixIcon: Icon(Iconsax.direct)),
                    ),
                    const SizedBox(height: 16),

                    //phone number
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: "Phone number",
                          prefixIcon: Icon(Iconsax.call)),
                    ),
                    const SizedBox(height: 16),

                    //password
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Iconsax.password_check)),
                    ),
                    const SizedBox(height: 16),

                    //terms
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value:
                                isChecked, // Valoarea actuală a checkbox-ului
                            onChanged: (value) {
                              setState(() {
                                isChecked =
                                    value!; // Actualizarea valorii variabilei isChecked cu valoarea nouă a checkbox-ului
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text("I agree to Privacy Policy and Terms of use",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 16),

                    //sign up button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen1()),
                          );
                        },
                        child: const Text("Create account"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
