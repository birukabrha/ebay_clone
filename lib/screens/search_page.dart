import 'package:ebay_clone/widgets/search.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          SearchBar(),
          Text('sgsgsdgsdgsdg'),
          Container(
            color: Colors.blueAccent,
            height: 30,
            width: MediaQuery.of(context).size.width,
          )
        ],
        
      ),
    );
  }
}