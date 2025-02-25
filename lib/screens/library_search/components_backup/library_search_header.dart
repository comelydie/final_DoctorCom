import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class LibarySearchHeader extends StatelessWidget {
  const LibarySearchHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SearchField(),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Cart Icon.svg",
          //  press: () {},
          // ),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Bell.svg",
          //   numOfitem: 3,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}
