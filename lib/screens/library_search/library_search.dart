import 'package:Doctorcom/components/coustom_bottom_nav_bar.dart';
import 'package:Doctorcom/screens/library_search/components/search_library.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import 'components/body.dart';

class LibrarySearch extends StatelessWidget {
  static String routeName = "/library_search";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchLibrary(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
