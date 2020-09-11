import 'package:flutter/material.dart';
import 'package:menon_health_tech/modals/Patient.dart';
import 'package:menon_health_tech/screens/Reports/PatientReportTable.dart';
import 'package:menon_health_tech/screens/Reports/ReportPatient.dart';

class PatientProfile extends StatelessWidget {
  final Patient p;
  PatientProfile(this.p);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("img/doctor.png"),
            ),
            Divider(),
            SizedBox(
              height: 40,
            ),
            Text("Name",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.grey)),
            Text(
              p.firstName + " " + p.lastName,
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Height",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.grey)),
            Center(
              child: Text(
                p.height + " CM",
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Weight",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.grey)),
            Center(
              child: Text(
                p.weight + " KG",
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportList(p.phone)));
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text("See Health Trend",
                    style: TextStyle(fontSize: 30, color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
