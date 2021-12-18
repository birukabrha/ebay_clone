// ignore_for_file: prefer_const_constructors

import 'package:ebay_clone/screens/email_registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 15, 0),
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
            height: 420,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(350, 45),
              maximumSize: const Size(350, 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            ),
            onPressed: () {
              print('Email');
              Get.to(() => EmailRegistration());
            },
            child: Text('Use your email'),
          ),
          SizedBox(
            height: 6,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(350, 45),
              maximumSize: const Size(350, 45),
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
                Text('Continue with Google'),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(350, 45),
              maximumSize: const Size(350, 45),
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
                Text('Continue with Facebook'),
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
                minimumSize: const Size(350, 45),
                maximumSize: const Size(350, 45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                shadowColor: Colors.white,
                side: BorderSide(
                  width: 2.0,
                  color: Colors.blue,
                )),
            onPressed: () {
              print('business account pressed');
            },
            child: Text('Create a business account',
                style: TextStyle(
                  color: Colors.blue,
                )),
          ),
        ],
      )),
    );
  }
}
