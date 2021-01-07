import 'dart:async';

import 'package:Doctorcom/components/product_contentsdetail.dart';
import 'package:Doctorcom/constants.dart';
import 'package:Doctorcom/screens/home/components/library_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<ProductContentsdetail> productContentsdetails = [];
  var queryResultSet = [];
  var tempSearchStore = [];

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

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        tempSearchStore = []; //comment this if you want to always show.
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    tempSearchStore = [];
    queryResultSet.forEach((element) {
      if (element['Name'].startsWith(capitalizedValue)) {
        setState(() {
          tempSearchStore.add(element);
        });
      }
    });
  }

  _getSnapShots() {
    SearchService().searchByName().map((snapshot) {
      snapshot.then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    }).toList();
  }

  @override
  void initState() {
    _getSnapShots();
    readFireStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // SizedBox(height: getProportionateScreenHeight(20)),
            // LibarySearchHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      onChanged: (val) {
                        initiateSearch(val.toUpperCase());
                      },
                      //onChanged: (val){initiateSearch(val.toUpperCase());},
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: getProportionateScreenWidth(20)),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Search product",
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Container(
              child: SizedBox(
                height: SizeConfig.screenHeight * 0.87,
                child: ListView(children: <Widget>[
                  SizedBox(height: 10.0),
                  GridView.count(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      primary: false,
                      shrinkWrap: true,
                      children: tempSearchStore.map((element) {
                        return buildResultCard(element);
                      }).toList())
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        print('you click = $data');
       
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 2.0,
          child: Container(
              child: Center(
                  child: Text(
            data['Name'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          )))),
    );
  }
}

class SearchService {
  List<Future<QuerySnapshot>> searchByName() {
    return [
      Firestore.instance.collection('contents').where('Name').getDocuments(),
    ];
  }
}
