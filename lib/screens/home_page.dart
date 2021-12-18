// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay_clone/auth_controller.dart';
import 'package:ebay_clone/screens/cart.dart';
import 'package:ebay_clone/screens/product_detail.dart';
import 'package:ebay_clone/screens/registration_page.dart';
import 'package:ebay_clone/screens/search_page.dart';
import 'package:ebay_clone/widgets/search.dart';
import 'package:ebay_clone/widgets/drawer.dart';
import 'package:ebay_clone/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _searchVisible = true;

  @override
  Widget build(BuildContext context) {
    // var _user = AuthController.instance.getUser();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(child: HDrawer()),
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        title: Container(
          width: 62,
          height: 25,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/logo.png'))),
        ),
        actions: <Widget>[
          _searchVisible ? Container() : Icon(Icons.search),
          SizedBox(
            width: 2,
          ),
          GestureDetector(
              onTap: () async {
                var _user = await AuthController.instance.getUser();
                if (_user.toString() == 'null') {
                  Get.to(() => LoginPage());
                } else {
                  Get.to(() => Cart());
                }
              },
              child: Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //Search Bar container
            GestureDetector(
              onTap: () {
                // Get.to(()=>SearchBar());
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Container(
                  height: 30,
                  margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  padding: EdgeInsets.all(8),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.search),
                      Text(
                        'Search on Ebay',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Icon(Icons.camera_alt),
                      Icon(Icons.mic)
                    ],
                  ),
                ),
              ),
            ),
            // Options horizontally scrollable
            Container(
              height: 80,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120,
                      height: 40,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            labels[index]['icon'],
                            color: Colors.black87,
                          ),
                          Text(
                            labels[index]['text'],
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            //Sign in or register message, Should not be created if the user is signed in
            FutureBuilder(
                future: AuthController.instance.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.data.toString() == 'null') {
                    return Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      height: 110,
                      child: Column(
                        children: [
                          Text(
                            'Sign in so we can personalize your eBay experience',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: const Size(120, 40),
                                    maximumSize: const Size(120, 40),
                                    primary: Colors.transparent,
                                    onPrimary: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    side: BorderSide(
                                      width: 2.0,
                                      color: Colors.blue,
                                    )),
                                onPressed: () {
                                  Get.to(() => RegistrationPage());
                                },
                                child: Text('Register'),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      minimumSize: const Size(120, 40),
                                      maximumSize: const Size(120, 40),
                                      primary: Colors.transparent,
                                      onPrimary: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                      side: BorderSide(
                                        width: 2.0,
                                        color: Colors.blue,
                                      )),
                                  onPressed: () {
                                    Get.to(() => LoginPage());
                                  },
                                  child: Text('Sign in'))
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
            // Pick of the day portion, different items from different categories
            Container(
              height: 350,
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Row(
                      children: const <Widget>[
                        Text(
                          'Pick of the day',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(width: 3),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        // print(snapshot.data!.docs[0]['name']);
                        return ListView(
                            scrollDirection: Axis.horizontal,
                            padding:
                                EdgeInsets.only(right: 12, left: 12, top: 40),
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => ProductDetail(),
                                            arguments: [data]);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        width: 155,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.white30,
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    data['image'][0]))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: 155,
                                      child: Text(
                                        data['name'],
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'US \$${data['price'].toString()}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: 155,
                                      child: Text(
                                        data['discountRate'].toString() == '0'?'':'${data['discountRate'].toString()}% discount',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList());
                      })
                ],
              ),
            ),

            //Popular Categories circular avatar
            Container(
              height: 420,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Explore Popular Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.73,
                    ),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 12),
                    primary: false,
                    itemCount: grid.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.transparent,
                        elevation: 0.0,
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: grid[index]['color'],
                              child: Center(
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(grid[index]['image']),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                            ),
                            Text(grid[index]['text'],
                                textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
