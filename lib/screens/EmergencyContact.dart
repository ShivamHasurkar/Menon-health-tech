import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EmergencyContactstate();
  }
}

class _EmergencyContactstate extends State<EmergencyContact> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "List View",
      home: Scaffold(
          appBar: AppBar(title: Text("Emergency Contact")),
          body: getListView()),
    );
  }
}

Widget getListView() {
  var listview = ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.help),
        title: Text("Ambulance"),
        subtitle: Text("(+91)9172176438"),
        trailing: Icon(Icons.phone, color: Colors.green),
        onTap: () {
          launch("tel:9172176438");
        },
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text("Blood bank"),
        subtitle: Text("(+91)9307473842"),
        trailing: Icon(Icons.phone, color: Colors.green),
        onTap: () {
          launch("tel:)9307473842");
        },
      ),
      ListTile(
        //contentPadding: EdgeInsets.all(5),
        focusColor: Colors.cyanAccent,
        leading: Icon(Icons.help),
        title: Text("Ambulance"),
        subtitle: Text("(+91)9307473842"),
        trailing: Icon(Icons.phone, color: Colors.green),
        onTap: () {
          launch("tel:9307473842");
        },
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text("Scan / X-ray"),
        subtitle: Text("(+91)9307473842"),
        trailing: Icon(Icons.phone, color: Colors.green),
        onTap: () {
          launch("tel:9307473842");
        },
      ),
    ],
  );
  return listview;
}
