import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

import 'dart:async';

import 'package:Doctorcom/components/product_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    show CollectionReference, DocumentSnapshot, Firestore, QuerySnapshot;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<ProductMenu> productMenus = [];

  //Method

  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = fireStore.collection('teach');
    subscription = await collectionReference.snapshots().listen((dataSnapshop) {
      snapshots = dataSnapshop.documents;

      for (var snapshot in snapshots) {
        String name = snapshot.data['Name'];
        print('name ==> $name');

        String url = snapshot.data['Url'];

        ProductMenu productMenu = ProductMenu(name, url);

        setState(() {
          productMenus.add(productMenu);
          name = productMenu.name;
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
          border: Border.all(width: 0.0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(30.0)),
      width: SizeConfig.screenWidth * 0.3,
      child: Image.network(
        productMenus[index].url,
        fit: BoxFit.contain,
      ),
    );
  }

  /* Widget showtext(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        showName(index)],
    );
  }
*/
  Widget showName(int index) {
    return Text(
      productMenus[index].name,
      style: TextStyle(fontSize: 24.0),
    );
  }

  Widget showListMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: SizeConfig.screenWidth*0.8,
          child: Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: productMenus.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Container(
                      child: Card(
                        margin: EdgeInsets.all(25),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // showImage(index),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  showImage(index),
                                  showName(index),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                    print('you click index = $index');
                    var showDetailRoute = MaterialPageRoute(
                        builder: (BuildContext context) => ShowDetail(
                              productMenu: productMenus[index],
                            ));
                    Navigator.of(context).push(showDetailRoute);

                    ///click ที่รูปแล้วไปอีกหน้า
                  },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

/*
  Widget showListMenu() {
    return SafeArea(
      child: Center(
        child: Container(
          width: SizeConfig.screenWidth*0.8,
          child: ListView.builder(
            itemCount: productMenus.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  height: SizeConfig.screenHeight*0.3,
                  child: Card(
                    margin: EdgeInsets.all(25),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                       // showImage(index),
                        Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               showImage(index),
                               showName(index),
                             ],
                           ),
                        ),
                      ],
                      /*
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        showImage(index),

                        SizedBox(
                          //width: 8.0,
                        ),
                        //showtext(index),
                      ],
                      */
                    ),
                  ),
                ),
                onTap: () {
                  print('you click index = $index');
                  var showDetailRoute = MaterialPageRoute(
                      builder: (BuildContext context) => ShowDetail(
                            productMenu: productMenus[index],
                          ));
                  Navigator.of(context).push(showDetailRoute);

                  ///click ที่รูปแล้วไปอีกหน้า
                },
              );
            },
          ),
        ),
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      child: showListMenu(),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ShowDetail extends StatefulWidget {
  final ProductMenu productMenu;
  ShowDetail({Key key, this.productMenu}) : super(key: key); //รับค่าของmodel

  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  // Explicit
  ProductMenu productMenu;
  String name = '', url = '';

  // Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      productMenu = widget.productMenu;
      name = productMenu.name;
      url = productMenu.url;
      print('name = $name');
    });
  }

  Widget showName() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        productMenu.name,
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.purple,
        ),
      ),
    );
  }

  Widget showImage() {
    return Container(
      height: 170,
      child: Image.network(
        productMenu.url,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สอนลงระบบปฎิบัติการ'),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          showName(),
          showImage(),
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: getProportionateScreenHeight(50)),
          ],
        ),
      ),
    );
  }
}
*/
