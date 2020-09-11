import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/forms/registerForm.dart';
import 'package:menon_health_tech/screens/DoctorHome/PatientList.dart';
import 'package:menon_health_tech/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:menon_health_tech/screens/login_web/LoginWeb.dart';
import 'package:menon_health_tech/widgets/Loading.dart';

class AuthWeb extends StatefulWidget {
  @override
  _AuthWebState createState() => _AuthWebState();
}

class _AuthWebState extends State<AuthWeb> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Enter Phone Number',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
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
                    child: Text('Proceed'),
                    onPressed: () async {
                      String phone = "+91" + phoneController.text.trim();
                      var rt = await DB().isWho(phone);

                      if (rt == null) {
                        print("Waiting");
                      } else if (rt == "Doctor" || rt == "Patient") {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (context) => LoginWeb(phone)));
                      } else {
                        if (rt == "Doctor") {
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (context) => RegisterForm(phone)));
                        }
                      }
                    },
                  )),
            ],
          )),
    );
  }
}

// Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("New User Sign Up",
//                 style: TextStyle(fontSize: 34, color: Colors.black)),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "Website Does not Support Phone OTP Auth use Password Instead",
//               style: TextStyle(color: Colors.red),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               cursorColor: Colors.black,
//               controller: _mobController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(hintText: "Mobile Number"),
//               autofocus: false,
//               maxLength: 10,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               cursorColor: Colors.black,
//               controller: _passController,
//               obscureText: true,
//               decoration:
//                   InputDecoration(hintText: "Password ( min 6 character )"),
//               autofocus: false,
//               maxLength: 10,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               cursorColor: Colors.black,
//               controller: _cPassController,
//               decoration: InputDecoration(hintText: "Confirm Password"),
//               autofocus: false,
//               maxLength: 10,
//               obscureText: true,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             RaisedButton(
//               onPressed: () async {
//                 print("Here");
//                 String phone = "+91" + _mobController.text.toString().trim();
//                 String pass = _passController.text.toString().trim();
//                 String cPass = _cPassController.text.toString().trim();

//                 if (pass.isNotEmpty && cPass.isNotEmpty && phone.length == 13) {
//                   if (pass.length > 5 && pass == cPass) {
//                     print("here");
//                     var _auth = FirebaseAuth.instance;
//                     var rt = await _auth.createUserWithEmailAndPassword(
//                         email: phone + "@menon.in", password: pass);
//                     var user = rt.user;
//                     if (user != null)
//                       Navigator.of(context).pushReplacement(
//                           new MaterialPageRoute(
//                               builder: (context) => RegisterForm(phone)));
//                   }
//                 } else {
//                   ShowAlert("Error", "Incorrect Inputs", context);
//                 }
//               },
//               color: Colors.blue,
//               child: Text(
//                 "Sign Up",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "Already an User ? ",
//               style: TextStyle(fontSize: 20, color: Colors.grey),
//             ),
//             SizedBox(height: 5),
//             RaisedButton(
//               child: Text("Log IN"),
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(
//                     new MaterialPageRoute(builder: (context) => LoginWeb()));
//               },
//               color: Colors.blue,
//             )
//           ],
//         ),
