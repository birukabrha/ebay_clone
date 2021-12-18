// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:ebay_clone/screens/login_page.dart';
import 'package:ebay_clone/screens/registration_pass.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailRegistration extends StatefulWidget {
  EmailRegistration({Key? key}) : super(key: key);

  @override
  _EmailRegistrationState createState() => _EmailRegistrationState();
}

 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _EmailRegistrationState extends State<EmailRegistration> {
  var emailController = TextEditingController();
  var fnameController = TextEditingController();
  var snameController = TextEditingController();

  bool isButtonActive = false;

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
          //Lets get started text container
          Container(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Let's Get Started",
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
          Form(
            key: _formKey,
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if(value == '') {
                        return "Enter your email";
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: fnameController,
                    decoration: InputDecoration(
                      labelText: 'First name',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: snameController,
                    decoration: InputDecoration(
                      labelText: 'Surname',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ])),
          ),

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
                    print('Continue button pressed');
                    Get.to(()=>RegistrationPass(),
                      arguments: [emailController.text,fnameController.text,snameController.text]);
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Create a business account',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              'https://signup.ebay.com/pa/crte?lang=en&acntType=business&mobile=1');
                        }),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Already a member?',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(text: ' '),
                        TextSpan(
                            text: 'Sign in',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => LoginPage());
                              })
                      ]),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
