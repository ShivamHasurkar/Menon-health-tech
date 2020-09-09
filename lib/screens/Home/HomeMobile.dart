import 'package:flutter/cupertino.dart';

class HomeMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(5),
      height: h,
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: h / 3,
            width: w,
            child: Image.asset("Images/doctor.png"),
          ),
          Text("Doctor",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            height: h / 3,
            width: w,
            child: Image.asset("Images/doctor.png"),
          ),
          Text("Doctor",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
