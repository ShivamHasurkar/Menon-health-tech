import 'package:flutter/material.dart';
import 'package:menon_health_tech/constants/app_colors.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/widgets/Loading.dart';

import 'PatientProfile.dart';

class PatientList extends StatelessWidget {
  final String phone;
  PatientList(this.phone);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: primaryColor,
        child: FutureBuilder(
            future: DB().getPatient(phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text(
                      "No Patients Yet",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              } else {
                print(snapshot.data[0].firstName);
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int i) {
                      return Divider(
                        color: Colors.transparent,
                      );
                    },
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(10),
                        tileColor: Colors.white,
                        leading: CircleAvatar(
                            backgroundImage: AssetImage("Images/doctor.png")),
                        title: Text(
                          snapshot.data[index].firstName +
                              " " +
                              snapshot.data[index].lastName,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(snapshot.data[index].phone),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      PatientProfile(snapshot.data[index])));
                        },
                      );
                    });
              }
            }),
      ),
    );
  }
}
