import 'package:Doctorcom/screens/about_contact/components/tel_assist.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TelAssist(),
          ],
        ),
      ),
    );
  }
}
