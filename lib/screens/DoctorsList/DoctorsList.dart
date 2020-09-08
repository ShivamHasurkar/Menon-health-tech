import 'package:flutter/material.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/modals/Doctor.dart';

import 'DoctorProfile.dart';

class DoctordList extends StatefulWidget {
  @override
  _DoctordListState createState() => _DoctordListState();
}

class _DoctordListState extends State<DoctordList> {
  Color c;
  List<Doctor> doctors;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.teal,
        child: FutureBuilder(
            future: DB().getDoctors(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text("No doctors are using this Software"),
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
                        subtitle: Text(snapshot.data[index].degree),
                        trailing: Icon(
                          () {
                            if (snapshot.data[index].verified) {
                              c = Colors.green;
                              return (Icons.verified);
                            } else {
                              c = Colors.red;
                              return Icons.new_releases;
                            }
                          }(),
                          color: c,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorProfile(snapshot.data[index])));
                        },
                      );
                    });
              }
            }),
      ),
    );
  }
}
