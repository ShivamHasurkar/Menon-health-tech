import 'package:flutter/material.dart';
import 'package:menon_health_tech/screens/Tutorial/tutorialCarousel.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'TutorialDesktop.dart';

class TutorialWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Expanded(
        child: ScreenTypeLayout(
          mobile: TutorialCarousel(),
          desktop: TutorialDesktop(),
        ),
      ),
    );
  }
}
