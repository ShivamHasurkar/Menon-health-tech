import 'package:flutter/material.dart';
import 'package:menon_health_tech/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CovidKITMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Buy Covid KIT",
              style: TextStyle(
                  fontSize: 35,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontFamily: "Sans Sarif"),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              padding: EdgeInsets.all(20),
              color: primaryColor,
              onPressed: () {
                launch("tel:8237342691");
              },
              child: Text(
                "Click To Buy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
