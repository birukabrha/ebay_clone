import 'package:ebay_clone/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;

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
          'Shopping basket',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
        padding: EdgeInsets.all(5.0),
        child: InkResponse(
            onTap: () {
              Get.to(()=>ProductDetail());
            },
            child: Material(
              child: Container(
                  height: 380.0,
                  padding: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Image.network(
                                    argumentData[0]['image'][0],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Container(
                                child: true
                                    ? const Icon(
                                        Icons.favorite,
                                        size: 20.0,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        size: 20.0,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "${argumentData[0]['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Text(
                                "\$${argumentData[0]['price'].toString()}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            )),
    ),
      )
      );
  }
}