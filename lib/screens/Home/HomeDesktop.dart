import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var f = w / h;
    return Container(
        padding: EdgeInsets.all(5),
        height: h,
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Register as",
              style: TextStyle(
                  fontSize: 30 * f,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
            Row(
              children: [
                Container(
                  height: h / 1.5,
                  width: w / 3,
                  color: Colors.blue,
                  child: Text(
                    "Doctor",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25 * f),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
