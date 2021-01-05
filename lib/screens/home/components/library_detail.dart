import 'package:Doctorcom/components/product_contentsdetail.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class LibraryDetail extends StatefulWidget {
  final ProductContentsdetail productContentsdetail;
  LibraryDetail({Key key, this.productContentsdetail}) : super(key: key);

  @override
  _LibraryDetailState createState() => _LibraryDetailState();
}

class _LibraryDetailState extends State<LibraryDetail> {
  ProductContentsdetail productContentsdetail;
  String name = '', problem = '', solve = '', url = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      productContentsdetail = widget.productContentsdetail;
      name = productContentsdetail.name;
      problem = productContentsdetail.problem;
      solve = productContentsdetail.solve;
      url = productContentsdetail.url;
      print('name = $name');
      print('problem = $problem');
    });
  }

  Widget showName() {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        productContentsdetail.name,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.purple,
        ),
      ),
    );
  }

  Widget showText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        productContentsdetail.solve,
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.purple,
        ),
      ),
    );
  }

  Widget showProlem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        showProlem(),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('วิธีแก้ปัญหา'),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          
          showText(),
         
          
        ],
      ),
    );
  }
}
