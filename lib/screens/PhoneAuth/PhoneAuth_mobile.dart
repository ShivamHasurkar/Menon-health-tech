import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_auth_web/firebase_auth_web_recaptcha_verifier_factory.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menon_health_tech/constants/app_colors.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/forms/registerForm.dart';
import 'package:menon_health_tech/screens/DoctorHome/PatientList.dart';
import 'package:menon_health_tech/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:menon_health_tech/widgets/CustomAlert.dart';
import 'package:menon_health_tech/widgets/CustomLoading.dart';
import 'package:menon_health_tech/widgets/Loading.dart';

class PhoneAuthMobile extends StatefulWidget {
  @override
  _PhoneAuthMobileState createState() => _PhoneAuthMobileState();
}

class _PhoneAuthMobileState extends State<PhoneAuthMobile> {
  Color btn_color = Colors.blue;
  Widget btn_child = Text(
    "Send OTP",
    style: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  );
  Widget btn_pressed = Text(
    "Send OTP",
    style: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  );
  final PageController contr = PageController();

  final TextEditingController _mobController = TextEditingController();

  final TextEditingController _codeController = TextEditingController();

  final _firebaseAuth = FirebaseAuth.instance;

  Future authenticatePhone(String phone) async {
    phone = "+91" + phone;
    var result = await DB().isWho(phone);
    if (result == null) {
      ShowLoading(context).showLoading();
    } else {
      print(result);
      if (result == "Doctor") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PatientList(phone)));
      } else if (result == "Patient") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PatientHome(phone)));
      } else {
        if (kIsWeb) {
          document.body.appendHtml("<div id='Container'></div>");
          var verifier = RecaptchaVerifier(
              container: "Container", parameters: {'callback': () {}});
          // print(container);
          print("cwe");
          try {
            var _auth = FirebaseAuthWeb.instance;
            var res = await _auth.signInWithPhoneNumber(
                phone, RecaptchaVerifierFactoryWeb.instance);
          } catch (e) {
            print("Catch");
            print(e);
            return e.message;
          }
        } else {
          try {
            _firebaseAuth.verifyPhoneNumber(
                phoneNumber: phone,
                verificationCompleted: (PhoneAuthCredential credential) async {
                  Navigator.of(context).pop();
                  print("Auto Verified");
                  var result =
                      await _firebaseAuth.signInWithCredential(credential);
                  User user = result.user;
                  if (user != null) {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (context) => RegisterForm(user.phoneNumber)));
                  }
                },
                verificationFailed: (FirebaseAuthException fe) {
                  print(fe);
                  print(fe.message);
                  return fe.message;
                },
                codeSent: (String verificationID, int resendToken) async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Enter OTP"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: _codeController,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Confirm"),
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () async {
                                CircularProgressIndicator();
                                final code = _codeController.text.trim();
                                AuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationID,
                                        smsCode: code);

                                UserCredential result = await _firebaseAuth
                                    .signInWithCredential(credential);
                                if (result == null) {
                                  ShowLoading(context).showLoading();
                                }
                                User user = result.user;

                                if (user != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterForm(user.phoneNumber)));
                                } else {
                                  ShowAlert("Login error", "Login Failed",
                                          context)
                                      .showAlertDialog();
                                  Navigator.pop(context);
                                }
                              },
                            )
                          ],
                        );
                      });
                },
                codeAutoRetrievalTimeout: (String s) {
                  print("AutoRetrival Time out!");
                });
          } catch (e) {
            print(e);
            return e.message;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: [
              Text(
                "Enter Mobile Number to Continue",
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Text("You will receive OTP on the below entered Mobile Number"),
              SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: Colors.white,
                controller: _mobController,
                keyboardType: TextInputType.number,
                autofocus: false,
                maxLength: 10,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 34),
                smartDashesType: SmartDashesType.enabled,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 25,
              ),
              RaisedButton(
                padding: EdgeInsets.all(15),
                color: btn_color,
                onPressed: () async {
                  setState(() {
                    btn_child = btn_pressed;
                    btn_color = Colors.grey;
                  });
                  String phone = _mobController.text.trim();
                  if (phone.length != 10) {
                    ShowAlert("Incorrect", "Please Check entered Mobile Number",
                        context);
                    setState(() {
                      btn_color = Colors.blue;
                    });
                  }
                  var rt = await authenticatePhone(phone);
                  if (rt == null) {
                    btn_child = Loading();
                  }
                },
                child: btn_child,
              )
            ],
          )),
    );
  }
}
