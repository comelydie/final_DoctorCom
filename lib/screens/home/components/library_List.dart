import 'dart:async';

import 'package:Doctorcom/components/product_contentsdetail.dart';
import 'package:Doctorcom/screens/home/components/library_detail.dart';
import 'package:Doctorcom/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';

class LibraryList extends StatefulWidget {
  @override
  _LibraryListState createState() => _LibraryListState();
}

class _LibraryListState extends State<LibraryList> {
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<ProductContentsdetail> productContentsdetails = [];

  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = fireStore.collection("contents");
    subscription = await collectionReference.snapshots().listen((dataSnapshop) {
      snapshots = dataSnapshop.documents;

      for (var snapshot in snapshots) {
        // print('snapshot = $snapshot');

        String name = snapshot.data['Name'];
        //print('name = $name');

        String problem = snapshot.data['Problem'];
        String solve = snapshot.data['Solve'];
        String url = snapshot.data['Url'];

        ProductContentsdetail productContentsdetail =
            ProductContentsdetail(name, problem, solve, url);

        setState(() {
          productContentsdetails.add(productContentsdetail);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.0),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(width: 0.0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(30.0)),
      width: 100.0,
      height: 100.0,
      child: Image.network(
        productContentsdetails[index].url,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showName(int index) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.65,
      child: Text(
        productContentsdetails[index].name,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget showText(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        showName(index),
      ],
    );
  }

  Widget showListMenucontents() {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: SizeConfig.screenHeight,
            child: ListView.builder(
              itemCount: productContentsdetails.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    // decoration: index % 2 == 0
                    //     ? BoxDecoration(color: Colors.yellow[50])
                    //     : BoxDecoration(color: Colors.yellow[200]),

                    child: Card(
                      margin: EdgeInsets.all(5),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          showImage(index),
                          SizedBox(
                            width: 5.0,
                          ),
                          showText(index),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    print('you click index = $index');
                    var showContentsdetailRoute = MaterialPageRoute(
                        builder: (BuildContext context) => LibraryDetail(
                              productContentsdetail:
                                  productContentsdetails[index],
                            ));
                    Navigator.of(context).push(showContentsdetailRoute);

                    ///click ที่รูปแล้วไปอีกหน้า
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: showListMenucontents(),
    );
  }
}
