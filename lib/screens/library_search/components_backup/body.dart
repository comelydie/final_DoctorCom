import 'package:Doctorcom/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // SizedBox(height: getProportionateScreenHeight(20)),
            // LibarySearchHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            //LibarySearchHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            
          ],
        ),
      ),
    );
  }
}
