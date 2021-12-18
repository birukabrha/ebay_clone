import 'package:ebay_clone/screens/home_page.dart';
import 'package:ebay_clone/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ebay_clone/auth_controller.dart';
import 'package:get/get.dart';

class HDrawer extends StatefulWidget {
  const HDrawer({Key? key}) : super(key: key);

  @override
  _HDrawerState createState() => _HDrawerState();
}

class _HDrawerState extends State<HDrawer> {
  //var loginStatus = 0;
  //var user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width/1.3,
        color: Colors.white,
        margin: const EdgeInsets.only(left: 10, top: 40),
        child: Column(
          children: [
            FutureBuilder(
                future: AuthController.instance.getUser(),
                builder: (context, snapshot) {
                  //If no user is logged in
                  if (snapshot.data.toString() != 'null') {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AllDrawer(
                        snapshot: snapshot.data,
                        isSnapshotNull: false,
                      );
                      // return Column(
                      //   children: [
                      //     Text('${snapshot.data}'),

                      //   ],
                      // );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                  //if a user is not logged in
                  else {
                    return AllDrawer(
                      snapshot: snapshot.data,
                      isSnapshotNull: true,
                    );
                  }
                }),
          ],
        ),
      ),
    );
    // return HDrawer()
  }
}
class AllDrawer extends StatelessWidget {
  AllDrawer(
      {Key? key, required this.snapshot, required this.isSnapshotNull})
      : super(key: key);

  final snapshot;
  final bool isSnapshotNull;
  // bool isPhotoUrlNull = false;
  @override
  Widget build(BuildContext context) {
    // if(snapshot.photoUrl == 'null') {
    //   isPhotoUrlNull = true;
    // }
    return Container(
      margin: const EdgeInsets.only(left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          !isSnapshotNull
              ? UserAccountsDrawerHeader(
                  accountName: Text(
                    snapshot.displayName.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                  accountEmail: const Text(''),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/user.png'),
                    // backgroundImage: isPhotoUrlNull?const AssetImage('images/user.png'):NetworkImage('${snapshot.photoUrl}'),
                  ),
                  decoration: const BoxDecoration(),
                )
              : GestureDetector(
                onTap: () {
                  Get.to(()=>LoginPage());
                },
                child: Container(
                  margin: const EdgeInsets.only(left:20,top: 40,bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Icon(Icons.account_circle_outlined,
                      size: 42,),
                      SizedBox(width: 25,),
                      Text('Sign in',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              ),
          ListTile(
            enabled: true,
            onTap: () {
              print(snapshot);
              Get.to(() => const HomePage());
            },
            leading: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.notifications_none_rounded),
            title: const Text('Notifications'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.inbox_rounded),
            title: const Text('Messages'),
          ),
          const Divider(
            color: Colors.black54,
          ),
          const Text(
            'My eBay',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 2
            ),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.watch_later_outlined),
            title: const Text('Watching'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.favorite_outline_rounded),
            title: const Text('Saved'),
          ),
          ListTile(
            enabled: true,
           onTap: () {
              !isSnapshotNull
                  ? Get.to(() => HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.credit_card_outlined),
            title: const Text('Buy Again'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text('Purchases'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.handyman_outlined),
            title: const Text('Bids & Offers'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.local_offer_outlined),
            title: const Text('Selling'),
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.credit_card_outlined),
            title: const Text('Categories'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.flash_on_outlined),
            title: const Text('Deals'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              !isSnapshotNull
                  ? Get.to(() => const HomePage())
                  : Get.to(() => LoginPage());
            },
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
          ),

          !isSnapshotNull?ListTile(
              onTap: () {
                AuthController.instance.logOut();
              },
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout')): Container()
        ],
      ),
    );
  }
}
