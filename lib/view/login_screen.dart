import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp_jobtask/view/register_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import 'Home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_emailController.text.isNotEmpty &&
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
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: 'Login Page'.text.make(),
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
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade400,
                      minimumSize: Size(context.screenWidth / 3, 35)),
                  child: "Login".text.white.make()),
              10.heightBox,
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      style: TextStyle(color: Colors.black),
                      text: 'Dont Have Account! '),
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
              ).onTap(() {
                Get.to(() => RegistrationPage());
              })
            ],
          ),
        ),
      ),
    );
  }
}
