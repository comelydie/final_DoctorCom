import 'package:Doctorcom/screens/library_search/library_search.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //SearchField(),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Cart Icon.svg",
          //   press: () {},
          // ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Search Icon.svg",
           // numOfitem: 3,
            press: () => Navigator.pushNamed(context, LibrarySearch.routeName),
          ),
        ],
      ),
    );
  }
}
