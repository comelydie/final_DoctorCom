import 'package:Doctorcom/components/coustom_bottom_nav_bar.dart';
import 'package:Doctorcom/enums.dart';
import 'package:Doctorcom/screens/library_search/library_search.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, LibrarySearch.routeName),
        child: Icon(Icons.search,size: 35,),
        backgroundColor: kPrimaryColor.withOpacity(0.8),
      ),
    );
  }
}
