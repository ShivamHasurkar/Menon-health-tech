import 'package:flutter/material.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/modals/Doctor.dart';

class DoctorProfile extends StatelessWidget {
  @required
  final Doctor d;
  DoctorProfile(this.d);
  @override
  Widget build(BuildContext context) {
    Color c;
    String t;
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
              backgroundImage: AssetImage("Images/doctor.png"),
            ),
            Divider(),
            SizedBox(
              height: 40,
            ),
            Text("Name",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.grey)),
            Text(
              "Dr." + d.firstName + " " + d.lastName,
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                d.degree,
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Consultation Fee",
                style: TextStyle(color: Colors.grey, fontSize: 25)),
            Text(
              "Rs." + d.consultationFee,
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              () {
                if (d.verified) {
                  c = Colors.green;
                  t = "Verified";
                } else {
                  c = Colors.orange;
                  t = "Not yet Verified";
                }
                return t;
              }(),
              style: TextStyle(fontSize: 25, color: c),
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
                onPressed: () {
                  DB().addPatienttoDoctor("8237342691", d.phone);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Alert"),
                          content: Text("Doctor Added"),
                          actions: [
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text("Add Doctor",
                    style: TextStyle(fontSize: 30, color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
