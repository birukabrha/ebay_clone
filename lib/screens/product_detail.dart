// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebay_clone/widgets/drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay_clone/auth_controller.dart';
import 'package:ebay_clone/list.dart';
import 'package:ebay_clone/screens/cart.dart';
import 'package:ebay_clone/screens/login_page.dart';
import 'package:ebay_clone/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ProductDetailState extends State<ProductDetail> {
  // Map<String, dynamic> data;
  // double rating = 5.0;
  dynamic argumentData = Get.arguments;

  bool isFav = false;

  int calculate() {
    double remaining = (argumentData[0]['itemsInStock']).toDouble() -
        (argumentData[0]['itemsSold']).toDouble();
    return remaining.toInt();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    int _current = 0;
    final CarouselController _controller = CarouselController();
// print(argumentData[0]['image']);
    final List<Widget> imageSliders = argumentData[0]['image']
        .map<Widget>((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.fill, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            // padding: EdgeInsets.symmetric(
                            //     vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return Scaffold(
      drawer: HDrawer(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        title: const Text(
          'Item',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share_rounded)),
          IconButton(
              onPressed: () async {
                var _user = await AuthController.instance.getUser();
                if (_user.toString() == 'null') {
                  Get.to(() => LoginPage());
                } else {
                  Get.to(() => Cart());
                }
              },
              icon: Icon(Icons.shopping_cart_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_sharp)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.blueAccent,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Image Slider and favorite button
              Stack(
                children: <Widget>[
                  Container(
                    width: w,
                    height: 400,
                    child: Column(children: [
                      Expanded(
                        child: CarouselSlider(
                          items: imageSliders,
                          carouselController: _controller,
                          options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              aspectRatio: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: argumentData[0]['image']
                            .asMap()
                            .entries
                            .map<Widget>((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ]),
                  ),
                  // ImageSlider(),
                  // Container(
                  //   width: w,
                  //   height: 400,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage(
                  //             'assets/images/i12.jpeg',
                  //           ),
                  //           fit: BoxFit.fill)),
                  // ),
                  Positioned(
                    right: 5,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFav = !isFav;
                        });
                      },
                      icon: isFav
                          ? const Icon(
                              Icons.favorite,
                              size: 20.0,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              size: 20.0,
                            ),
                    ),
                  )
                ],
              ),
              //Item Description big text
              Text(
                argumentData[0]['name'],
                style: TextStyle(fontSize: 20),
              ),
              //Item condition Description
              Text(
                argumentData[0]['condition'],
                style: TextStyle(color: Colors.black54, height: 1.5),
              ),
              //Item rating,should use another widget
              Row(
                children: [
                  StarRating(
                    rating: (argumentData[0]['rating']).toDouble(),
                    // onRatingChanged: (rating) =>
                    //     setState(() => this.rating = rating),
                  ),
                  Text('(1)'),
                ],
              ),
              //Item price and reduction rate or shippinf fees
              RichText(
                  text: TextSpan(
                      text: 'US \$${argumentData[0]['price']}',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                      children: [
                    // TextSpan(text: ' + '),
                    TextSpan(
                        text: (argumentData[0]['discountRate'] != 0)
                            ? '   ${argumentData[0]['discountRate']}% off. Great price'
                            : '',
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                  ])),
              //Estimated Delivery Time
              RichText(
                  text: TextSpan(
                      text: 'Est. Delivery ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                    TextSpan(
                        text: 'Wed, 29 Dec - Thu, 13 Jan',
                        style: TextStyle(fontWeight: FontWeight.w600))
                  ])),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('${argumentData[0]['itemsSold'].toString()} sold'),
                    VerticalDivider(
                      color: Colors.black,
                      width: 2,
                    ),
                    Text('30-days return'),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 6,
              ),

              //Buttons
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 45),
                      maximumSize: const Size(350, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onPressed: () {
                      print('Buy Now Button Pressed');
                    },
                    child: Text('Buy Now'),
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
                      print('Add to Basket button pressed');
                      Get.to(() => Cart(), arguments: [argumentData[0]]);
                    },
                    child: Text('Add to Basket',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
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
                      print('Make Offer Button Pressed');
                    },
                    child: Text('Make Offer',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
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
                      print('Add to watchlist button pressed');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_outline_rounded,
                            color: Colors.blue),
                        Text(
                          'Add to watchlist',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              //More like this Category
              Container(
                height: 310,
                padding: EdgeInsets.only(top: 20, bottom: 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'More like this',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Sponsored',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54),
                        ),
                      ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetail(),
                                              arguments: [data],
                                              preventDuplicates: false);
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
                                          data['discountRate'].toString() == '0'
                                              ? ''
                                              : '${data['discountRate'].toString()}% discount',
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
              //Similar customers also bought category
              Container(
                height: 300,
                padding: EdgeInsets.only(bottom: 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Similar customers also bought',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Sponsored',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54),
                        ),
                      ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetail(),
                                              arguments: [data],
                                              preventDuplicates: false);
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
                                          data['discountRate'].toString() == '0'
                                              ? ''
                                              : '${data['discountRate'].toString()}% discount',
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

              //About item Description
              Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    print('About item table description clicked');
                  },
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About this item',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Item details'),
                            SizedBox(
                              height: 5,
                            ),
                            DataTable(
                              headingRowHeight: 0,
                              columns: [
                                DataColumn(label: Container()),
                                DataColumn(label: Container()),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('Condition',
                                      style: TextStyle(color: Colors.black54))),
                                  DataCell(Text(
                                      argumentData[0]['condition'].toString()))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Quantity',
                                      style: TextStyle(color: Colors.black54))),
                                  DataCell(Column(
                                    children: [
                                      Text(
                                        '${calculate().toString()} remaining',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          '${argumentData[0]['itemsSold'].toString()} sold'),
                                    ],
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Seller Warranty',
                                      style: TextStyle(color: Colors.black54))),
                                  DataCell(Text(
                                      argumentData[0]['sellerWarranty'] == true
                                          ? 'Yes'
                                          : 'No'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Brand',
                                      style: TextStyle(color: Colors.black54))),
                                  DataCell(Text(argumentData[0]['brandName']))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Model',
                                      style: TextStyle(color: Colors.black54))),
                                  DataCell(Text(argumentData[0]['model']))
                                ]),
                              ],
                              columnSpacing: 70,
                              dividerThickness: 0,
                            )
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.width / 3,
                        right: 0,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              size: 35,
                            )))
                  ]),
                ),
              ),
              Divider(
                color: Colors.black,
              ),

              //Item description from the seller
              Container(
                child: GestureDetector(
                  onTap: () {
                    print('item description from the seller clicked');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item description from the seller',
                        style: TextStyle(fontSize: 16),
                      ),
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: RichText(
                              maxLines: 5,
                              text: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.format_quote_rounded)),
                                TextSpan(
                                    text: argumentData[0]['itemDesc'],
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        fontSize: 14))
                              ])),
                        ),
                        Positioned(
                            top: 15,
                            right: 0,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 35,
                                ))),
                      ]),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'See full description',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              //Postage returns and payment category
              Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    print('About item table description clicked');
                  },
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Postage, returns, and payments',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        DataTable(
                          dataRowHeight: 50,
                          headingRowHeight: 0,
                          columns: [
                            DataColumn(label: Container()),
                            DataColumn(label: Container()),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('Est.delivery',
                                  style: TextStyle(color: Colors.black54))),
                              DataCell(Text('Wed, 29 Dec - Thu, 13 Jan'))
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Returns',
                                  style: TextStyle(color: Colors.black54))),
                              DataCell(Column(
                                children: [
                                  Text(
                                    'Accepted within 30 days',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Buyer Pays return postage',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ))
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Payments',
                                  style: TextStyle(color: Colors.black54))),
                              DataCell(RichText(
                                  text: TextSpan(children: [
                                WidgetSpan(child: Icon(Icons.payment_sharp)),
                                WidgetSpan(
                                    child: Icon(Icons.card_travel_outlined)),
                                WidgetSpan(child: Icon(Icons.payment_sharp)),
                                WidgetSpan(child: Icon(Icons.payment_sharp)),
                                WidgetSpan(child: Icon(Icons.payment_sharp)),
                              ])))
                            ]),
                          ],
                          columnSpacing: 70,
                          dividerThickness: 0,
                        )
                      ],
                    ),
                    Positioned(
                        top: 70,
                        right: 0,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              size: 35,
                            )))
                  ]),
                ),
              ),

              //Shop with Confidence portion
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shop with confidence',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      leading: Icon(Icons.call),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Call the seller',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            maxLines: 3,
                          ),
                          Text(
                              'If you\'d like to speak directly to the seller, we\'ve verified the number'),
                          Text('+1(929) 510-7979',
                              style: TextStyle(color: Colors.blue))
                        ],
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 35,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.money),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'eBay Money Back Guarentee ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            maxLines: 3,
                          ),
                          Text('Get the item tou ordered or your money back'),
                        ],
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),

              //About this seller information Container
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About this seller',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      foregroundImage: AssetImage('assets/images/user.png'),
                    ),
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('seller(10882)'),
                          Text(
                              '${((argumentData[0]['rating'] * 100) / 5).toInt()}% positive feedback'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.favorite_outline_rounded,
                                  color: Colors.blue),
                              Text(
                                'Save this seller',
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                        ]),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 35,
                    ),
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Divider(
                      color: Colors.black,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Contact Seller',
                          style: TextStyle(color: Colors.blue),
                        )),
                    Divider(
                      color: Colors.black,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Visit Seller\'s shop',
                          style: TextStyle(color: Colors.blue),
                        )),
                    Divider(
                      color: Colors.black,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Seller\'s other items',
                          style: TextStyle(color: Colors.blue),
                        ))
                  ])
                ],
              )),

              //Buyers Also viewed
              Container(
                height: 300,
                padding: EdgeInsets.only(bottom: 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Buyers also viewed',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Sponsored',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54),
                        ),
                      ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetail(),
                                              arguments: [data],
                                              preventDuplicates: false);
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
                                          data['discountRate'].toString() == '0'
                                              ? ''
                                              : '${data['discountRate'].toString()}% discount',
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

              //Frequently bought together
              Container(
                height: 300,
                padding: EdgeInsets.only(bottom: 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Frequently bought together',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Sponsored',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54),
                        ),
                      ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetail(),
                                              arguments: [data],
                                              preventDuplicates: false);
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
                                          data['discountRate'].toString() == '0'
                                              ? ''
                                              : '${data['discountRate'].toString()}% discount',
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
              SizedBox(
                height: 5,
              ),
              //Ratings and Reviews container
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rating and Reviews',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            argumentData[0]['rating'].toString(),
                            style: TextStyle(fontSize: 40),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StarRating(
                                rating: (argumentData[0]['rating']).toDouble(),
                                // onRatingChanged: (rating) =>
                                //     setState(() => this.rating = rating),
                              ),
                              Text('1 product rating')
                            ],
                          )
                        ]),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Text(
                                  '${((argumentData[0]['rating'] * 100) / 5).toInt()}%'),
                            ),
                            Text('Good Value'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Text(
                                  '${((argumentData[0]['rating'] * 100) / 5).toInt()}%'),
                            ),
                            Text('Comfortable'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Text(
                                  '${((argumentData[0]['rating'] * 100) / 5).toInt()}%'),
                            ),
                            Text('Stylish'),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('This product has ratings, but no reviews yet.'),
                    Text('Be the first to write a review'),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),

              //Review button and other options
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 45),
                      maximumSize: const Size(350, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onPressed: () {
                      print('Write a review button pressed');
                    },
                    child: Text('Write a review'),
                  ),
                  SizedBox(
                    height: 56,
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
                      print('Share item button pressed');
                    },
                    child: Text('Share this item',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
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
                      print('Report item button pressed');
                    },
                    child: Text('Report this item',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //we think you will love category
              Container(
                height: 300,
                padding: EdgeInsets.only(top: 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'We think you will love',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Sponsored',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54),
                        ),
                      ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetail(),
                                              arguments: [data],
                                              preventDuplicates: false);
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
                                          data['discountRate'].toString() == '0'
                                              ? ''
                                              : '${data['discountRate'].toString()}% discount',
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
              // SizedBox(
              //   height: 5,
              // ),
              //Explore more options container model options
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Explore more options: Model',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 3),
                  Container(
                    height: 80,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        itemBuilder: (context, index) {
                          return Container(
                              alignment: Alignment.center,
                              width: 120,
                              height: 40,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.grey[200],
                              ),
                              child: Text(models[index]['name'],
                                  style: TextStyle(color: Colors.blue)));
                        }),
                  ),
                ],
              ),
              Container(
                height: 280,
                padding: EdgeInsets.only(bottom: 0),
                child: Stack(
                  children: <Widget>[
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
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  EdgeInsets.only(right: 12, left: 12, top: 40),
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetail()));
                                      Get.off(() => ProductDetail(),
                                          arguments: [data],
                                          preventDuplicates: false);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
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
                                            data['discountRate'].toString() ==
                                                    '0'
                                                ? ''
                                                : '${data['discountRate'].toString()}% discount',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList());
                        })
                  ],
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),

              //explore more options brand option
              Container(
                height: 300,
                padding: EdgeInsets.only(bottom: 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Explore more options: Brand',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetail(),
                                              arguments: [data],
                                              preventDuplicates: false);
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
                                          data['discountRate'].toString() == '0'
                                              ? ''
                                              : '${data['discountRate'].toString()}% discount',
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
              //more items to consider container
              Container(
                height: 300,
                padding: EdgeInsets.only(bottom: 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'More items to consider',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetail(),
                                              arguments: [data],
                                              preventDuplicates: false);
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
                                          data['discountRate'].toString() == '0'
                                              ? ''
                                              : '${data['discountRate'].toString()}% discount',
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
            ],
          ),
        ),
      ),
    );
  }
}
