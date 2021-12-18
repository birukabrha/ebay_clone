import 'package:ebay_clone/screens/home_page.dart';
import 'package:ebay_clone/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //Should be globally accessible on the app
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  //comes from firebase instance, it's more like a model that contains user info
  late Rx<User?> _user;
  
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);

    //binding our user to the stream, live info
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print('User isn\'t logged in');
      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  void register(String displayName, String email, password) async{
    try {
      UserCredential results = await auth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = results.user;
      user?.updateDisplayName(displayName);
    } catch (e) {
      Get.snackbar('About User', 'User Message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        titleText: const Text('Account creation failed.',
        style: TextStyle(
          color: Colors.white
        ),),
        messageText: Text(e.toString(),
        style: const TextStyle(
          color: Colors.white
        ),),
      );
    }
  }
  
    void logIn(String email, password) async{
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar('About User', 'Login Message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        titleText: const Text('Login failed.',
        style: TextStyle(
          color: Colors.white
        ),),
        messageText: Text(e.toString(),
        style: const TextStyle(
          color: Colors.white
        ),),
      );
    }
  }
  
    void logOut() async{
    await auth.signOut();
  }
  
  Future getUser() async {
    return await auth.currentUser;
  }

   Future getDisplayName() async {
    return await auth.currentUser?.displayName;
  }

}
