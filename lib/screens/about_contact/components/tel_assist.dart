import 'package:Doctorcom/components/product_contact.dart';
import 'package:Doctorcom/size_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart'
    show CollectionReference, DocumentSnapshot, Firestore, QuerySnapshot;

class TelAssist extends StatefulWidget {
  const TelAssist({
    Key key,
  }) : super(key: key);

  @override
  _TelAssistState createState() => _TelAssistState();
}

class _TelAssistState extends State<TelAssist> {
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<ProductContact> productContacts = [];

  //Method

  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = fireStore.collection("contact");
    subscription = await collectionReference.snapshots().listen((dataSnapshop) {
      snapshots = dataSnapshop.documents;

      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');

        String name = snapshot.data['Name'];
       // print('name = $name');

        String tel = snapshot.data['Tel'];
        String image = snapshot.data['Image'];

        ProductContact productContact = ProductContact(name, tel, image);

        setState(() {
          productContacts.add(productContact);
          tel = productContact.tel;
          print('tel = $tel');
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: SizeConfig.screenWidth * 0.35,
      height: SizeConfig.screenHeight * 0.12,
      child: Image.network(
        productContacts[index].image,
      ),
    );
  }


  Widget showName(int index) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Text(
        productContacts[index].name,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }



  Widget showText(int index) {
    return Container(
      // width: 200,
      /* child: Text(
      productContacts[index].tel,
      style: TextStyle(fontSize: 18.0, color: Colors.grey),
      
      ),*/

      child: SelectableText(
        productContacts[index].tel,
        style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
      ),
    );
  }

  phoneNumber(int index) {
    return productContacts[index].tel;
  }
/*
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                backgroundColor: Colors
                    .transparent, // no matter how big it is, it won't overflow
              ),
              title: Text('ช่างปราย', style: TextStyle(fontSize: 18)),
              subtitle: Text('โทร 0971565725', style: TextStyle(fontSize: 16)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('โทร'),
                  onPressed: () => launch("tel://0971565725"),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/

  Widget showListMenucontacts() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: SizeConfig.screenHeight,
                child: Container(
                  child: ListView.builder(
                    itemCount: productContacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                showImage(index),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      showName(index),
                                      showText(index),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 0.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          launch("tel:${phoneNumber(index)}");
                          //onTap: () => launch("tel:0971565725"),
                           print('คลิกเบอร์ = ${phoneNumber(index)}');
                        },
                        //onTap: () => launch("tel:0971565725"),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showListMenucontacts(),
    );
  }
}
