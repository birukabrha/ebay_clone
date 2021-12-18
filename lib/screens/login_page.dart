// ignore_for_file: prefer_const_constructors

import 'package:ebay_clone/screens/email_login.dart';
import 'package:ebay_clone/screens/home_page.dart';
import 'package:ebay_clone/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        title: Text(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 15, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Hello',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 1, 10, 1),
            child: Text(
              'You can use your email or username, or you can continue with your social account.',
              style: TextStyle(
                fontSize: 16,
              ),
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: 380,//make it 380
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(350, 50),
              maximumSize: const Size(350, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            ),
            onPressed: () {
              print('Email');
              Get.to(() => EmailLogin());
            },
            child: Text('Use email or username'),
          ),
          SizedBox(
            height: 6,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(350, 50),
              maximumSize: const Size(350, 50),
              primary: Colors.white,
              onPrimary: Colors.black54,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            ),
            onPressed: () {
              print('Google signin button pressed');
            },
            child: Row(
              children: const [
                Icon(Icons.g_mobiledata_rounded),
                SizedBox(
                  width: 80,
                ),
                Text('Sign in with Google'),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(350, 50),
              maximumSize: const Size(350, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            ),
            onPressed: () {
              print('Facebook sign in button pressed');
            },
            child: Row(
              children: const [
                Icon(Icons.facebook_rounded),
                SizedBox(
                  width: 80,
                ),
                Text('Sign in with Facebook'),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.transparent,
                minimumSize: const Size(350, 50),
                maximumSize: const Size(350, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                shadowColor: Colors.white,
                side: BorderSide(
                  width: 2.0,
                  color: Colors.blue,
                )),
            onPressed: () {
              print('Create account button pressed');
              Get.to(() => RegistrationPage());
            },
            child: Text('Create an account',
                style: TextStyle(
                  color: Colors.blue,
                )),
          ),
        ],
      )),
    );
  }
}
