import 'package:flutter/material.dart';
import 'package:menon_health_tech/constants/app_colors.dart';
import 'package:menon_health_tech/screens/DoctorsList/DoctorsList.dart';
import 'package:menon_health_tech/screens/EmergencyContact.dart';
import 'package:menon_health_tech/screens/HealthData/HealthData.dart';
import 'package:menon_health_tech/screens/Navigation_drawer/navbar_item.dart';
import 'package:menon_health_tech/screens/Navigation_drawer/navigation_drawer_header.dart';
import 'package:menon_health_tech/screens/Reports/PatientReportTable.dart';
import 'package:menon_health_tech/screens/Reports/ReportPatient.dart';

class PatientHome extends StatefulWidget {
  final String phone;
  PatientHome(this.phone);
  @override
  _PatientHomeState createState() => _PatientHomeState(phone);
}

class _PatientHomeState extends State<PatientHome> {
  final String phone;
  _PatientHomeState(this.phone);
  int i = 0;
  List<Widget> fragment = [];
  @override
  Widget build(BuildContext context) {
    fragment = [
      HealthData(phone),
      PatientReportTable(phone),
      DoctordList(),
      EmergencyContact(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Menon Health Tech"),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 10.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                child: Image(
                    image: AssetImage('Images/Menon and Menon Symbol.png'),
                    height: 50,
                    width: 50)),
          ),
        ],
      ),
      drawer: NavigationDrawer(
          phone: phone,
          onTap: (context, index) {
            Navigator.pop(context);
            setState(() {
              i = index;
            });
          }),
      body: fragment[i],
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final Function onTap;
  final String phone;

  NavigationDrawer({this.onTap, this.phone});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          NavigationDrawerHeader(phone),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 25),
            child: ListTile(
              title: NavBarItem("Data Entry"),
              leading: Icon(
                Icons.format_align_center,
                size: 30,
              ),
              onTap: () => onTap(context, 0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 25),
            child: ListTile(
              title: NavBarItem("Reports"),
              leading: Icon(
                Icons.timeline,
                size: 30,
              ),
              onTap: () => onTap(context, 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 25),
            child: ListTile(
              title: NavBarItem("Doctors Panel"),
              leading: Icon(
                Icons.local_hospital_sharp,
                size: 30,
              ),
              onTap: () => onTap(context, 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 25),
            child: ListTile(
              title: NavBarItem("Emergency Contacts"),
              leading: Icon(
                Icons.question_answer,
                size: 30,
              ),
              onTap: () => onTap(context, 3),
            ),
          ),
        ],
      ),
    );
  }
}
