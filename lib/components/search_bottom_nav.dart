import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBottomNav extends StatelessWidget {
  final Widget child;
  const SearchBottomNav({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          bottom: 0,
          left: 0,
          child: FloatingActionButton(
            onPressed: (){},
          ),
        )
      ],
    );
  }
}