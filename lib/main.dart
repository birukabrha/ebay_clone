import 'package:ebay_clone/auth_binding.dart';
import 'package:ebay_clone/cloudstore_check.dart';
import 'package:ebay_clone/screens/login_page.dart';
import 'package:ebay_clone/screens/product_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ebay_clone/screens/home_page.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        //checking snapshot or firbase connection error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        //checking for successful firebase connection or initialization
        if (snapshot.connectionState == ConnectionState.done) {
          //To check the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              //checking if stream snapshot has error
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

        
              //the active doesnt indicate that the user is logged in
              if (streamSnapshot.connectionState == ConnectionState.active) {
            
                var _user = streamSnapshot.data;
                return const HomePage();
              }

              //default return statement while checking the auth state
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                  // child: Text('Checking authentication...'),
                ),
              );
            },
          );
        }

        //default return statement while checking the snapshot or loading time
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
            // child: Text('Initializeing app...'),
          ),
        );
      },
    );
  }
}
