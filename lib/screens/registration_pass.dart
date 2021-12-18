// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_controller.dart';

class RegistrationPass extends StatefulWidget {
// final String email;
// final String fname;
// final String sname;

  // RegistrationPass({Key? key, required this.email, required this.fname, required this.sname}) : super(key: key);
  RegistrationPass({Key? key}) : super(key: key);

  @override
  _RegistrationPassState createState() => _RegistrationPassState();
}

class _RegistrationPassState extends State<RegistrationPass> {
  bool _isObscure = true;
  var passwordController = TextEditingController();

  dynamic argumentData = Get.arguments;

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
          'Create an account',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          //color: Colors.black,
          child: Column(
        children: <Widget>[
          //Create a password text container
          Container(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Create a password",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),

          //Password Textfield container
          Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(children: <Widget>[
                TextField(
                  controller: passwordController,
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
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
                          })),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    'At least 6 characters, at least 1 letter and a number or symbol.'),
                SizedBox(height: 100),
              ])),

          //Buttons container
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  'By selecting Create account, you agree to our User Agreement and acknowledge reading our User Privacy Notice.',
                  style: TextStyle(fontSize: 14),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'User Agreement',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'User Private Notice',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onSurface: passwordController==''?Colors.grey:Colors.blue,
                    minimumSize: const Size(350, 45),
                    maximumSize: const Size(350, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onPressed: () {
                    print('Create account button pressed');
                    print(argumentData[0]);
                    print(argumentData[1]);
                    print(argumentData[2]);
                    print(passwordController);

                    AuthController.instance
                        .register(argumentData[1],argumentData[0], passwordController.text);
                  },
                  child: Text(
                    'Create account',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
