// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:ebay_clone/screens/registration_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth_controller.dart';

class EmailLogin extends StatefulWidget {
  EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        title: const Text(
          'Sign in',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          //color: Colors.black,
          child: Column(
        children: <Widget>[
          //Lets get started text container
          Container(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Welcome",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),

          //TExtFormfield container
          Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })
                  ),
                  obscureText: _isObscure,
                ),
                SizedBox(
                  height: 20,
                ),
              ])),

          //Buttons container
          Container(
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 45),
                    maximumSize: const Size(350, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                        
                  ),
                  onPressed: () {
                    print('Signin button pressed');
                     AuthController.instance
                        .logIn(emailController.text, passwordController.text);
                    
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Text a temporary password',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          
                        }),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Reset your password',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          
                        }),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Create an account',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => RegistrationPage());
                        }),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
