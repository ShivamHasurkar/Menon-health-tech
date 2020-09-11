import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/screens/DoctorHome/PatientList.dart';
import 'package:menon_health_tech/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:menon_health_tech/widgets/Loading.dart';

class LoginWeb extends StatefulWidget {
  final String phone;
  LoginWeb(this.phone);
  @override
  _LoginWebState createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.phone.substring(3, 13);
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Login'),
                    onPressed: () async {
                      String phone = "+91" + nameController.text.trim();
                      String pass = passwordController.text.trim();

                      try {
                        var auth = FirebaseAuth.instance;
                        var cred = await auth.signInWithEmailAndPassword(
                            email: phone + "@menon.in", password: pass);
                        var user = cred.user;
                        if (user != null) {
                          var rt = await DB().isWho(phone);
                          if (rt == "Doctor") {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (context) => PatientList(phone)));
                          } else if (rt == "Patient") {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (context) => PatientHome(phone)));
                          } else {
                            Loading();
                          }
                        }
                      } catch (e) {
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text(e.message),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    },
                  )),
            ],
          )),
    );
  }
}
