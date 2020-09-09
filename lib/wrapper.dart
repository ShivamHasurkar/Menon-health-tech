import 'package:flutter/material.dart';
import 'package:menon_health_tech/screens/Home/HomeDesktop.dart';
import 'package:menon_health_tech/screens/Home/HomeMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => Expanded(
                child: ScreenTypeLayout(
              mobile: HomeMobile(),
              desktop: HomeDesktop(),
            )));
  }
}
