import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import 'Home.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        Get.offAll(() => const Home());
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            titleText: Text(
              'Warning!',
              style: TextStyle(color: Colors.white),
            ),
            messageText: Text(
              'Fill the from',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.blueAccent,
            borderRadius: 8,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = context.screenHeight * 0.09;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: 'Register Page'.text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              height.heightBox,
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                    ),
                    labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              15.heightBox,
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                    ),
                    labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              15.heightBox,
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                    ),
                    labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    minimumSize: Size(context.screenWidth / 3, 35)),
                onPressed: _register,
                child: "Register".text.white.make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
