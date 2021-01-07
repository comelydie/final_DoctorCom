import 'package:Doctorcom/components/coustom_bottom_nav_bar.dart';
import 'package:Doctorcom/constants.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import 'components/body.dart';

class LibrarySearch extends StatelessWidget {
  static String routeName = "/library_search";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>{Navigator.pop(context)},
          child: Icon(Icons.arrow_back),
          backgroundColor: kPrimaryColor,
        ),
      body: Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
