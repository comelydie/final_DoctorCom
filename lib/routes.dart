import 'package:Doctorcom/screens/about_contact/about_contact.dart';
import 'package:Doctorcom/screens/camera/camera.dart';
import 'package:Doctorcom/screens/home/home_screen.dart';
import 'package:Doctorcom/screens/library_search/library_search.dart';
import 'package:Doctorcom/screens/operating_system/operating_system.dart';
import 'package:Doctorcom/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LibrarySearch.routeName: (context) => LibrarySearch(),
  Camera.routeName: (context) => Camera(),
  OperatingSystem.routeName: (context) => OperatingSystem(),
  AboutContact.routeName: (context) => AboutContact(),
};
