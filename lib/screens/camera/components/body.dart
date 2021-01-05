import 'package:Doctorcom/screens/camera/components/camera_take.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: getProportionateScreenHeight(50)),
            CameraTake(),
          ],
        ),
      ),
    );
  }
}

