import 'package:flutter/material.dart';
import 'package:menon_health_tech/constants/app_colors.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/modals/HealthDataEntry.dart';
import 'package:menon_health_tech/widgets/Loading.dart';

class ReportList extends StatefulWidget {
  final String phone;

  ReportList(this.phone);
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  Color c;
  List<HealthDataEntry> h;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().readHealthData(widget.phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print("Future Builder");
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text("No Health Records!!"),
                  ),
                );
              } else {
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
                        tileColor: primaryColor,
                        leading: CircleAvatar(
                            backgroundImage: AssetImage("Images/doctor.png")),
                        title: Text(
                          "Oxygen Level:    " +
                              snapshot.data[index].oxy +
                              " SpO2\n" +
                              "Pulse:                 " +
                              snapshot.data[index].pulse +
                              " BPM\n" +
                              "Temprature:        " +
                              snapshot.data[index].temprature +
                              " F",
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text("Date: " +
                            snapshot.data[index].date
                                .toString()
                                .substring(0, 19)),
                        onTap: () {
                          HealthDataEntry he = snapshot.data[index];
                          print(he.cold);
                          var alertDialog = AlertDialog(
                            title: Text(
                              "Other Symptoms",
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                            content: Text("Cold    : " +
                                he.cold +
                                "\nCough : " +
                                he.cough +
                                "\nLoss of Taste : " +
                                he.lossofTaste +
                                "\nLoss of Smell : " +
                                he.lossofSmell +
                                "\nOther   : " +
                                he.other),
                          );

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alertDialog;
                              });
                        },
                      );
                    });
              }
            }),
      ),
    );
  }
}
