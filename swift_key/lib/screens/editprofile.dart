import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_key/screens/login1.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isChecked = false;

  // TextEditingController instances with hardcoded user data
  final TextEditingController _firstNameController =
      TextEditingController(text: "John");
  final TextEditingController _lastNameController =
      TextEditingController(text: "Doe");
  final TextEditingController _usernameController =
      TextEditingController(text: "johndoe");
  final TextEditingController _cnpController =
      TextEditingController(text: "123456789");
  final TextEditingController _emailController =
      TextEditingController(text: "johndoe@example.com");
  final TextEditingController _phoneNumberController =
      TextEditingController(text: "123-456-7890");

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _cnpController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update your account",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First name box
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: "First Name",
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Last name box
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: "Last Name",
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Username box
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Iconsax.user_tag),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // CNP box
                    TextFormField(
                      controller: _cnpController,
                      decoration: const InputDecoration(
                        labelText: "CNP",
                        prefixIcon: Icon(Iconsax.user_edit),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email box
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: Icon(Iconsax.direct),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Phone number
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: "Phone number",
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Terms
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "I agree to Privacy Policy and Terms of use",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Update account button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen1(),
                            ),
                          );
                        },
                        child: const Text("Update account"),
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
