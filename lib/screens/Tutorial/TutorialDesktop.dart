import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menon_health_tech/constants/app_colors.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/forms/registerForm.dart';
import 'package:menon_health_tech/screens/DoctorHome/PatientList.dart';
import 'package:menon_health_tech/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:menon_health_tech/widgets/CustomAlert.dart';
import 'package:menon_health_tech/widgets/CustomLoading.dart';

class TutorialDesktop extends StatefulWidget {
  @override
  _TutorialDesktopState createState() => _TutorialDesktopState();
}

class _TutorialDesktopState extends State<TutorialDesktop> {
  final PageController contr = PageController();
  final TextEditingController _mobController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  var _firebaseAuth = FirebaseAuth.instance;

  Future authenticatePhone(String phone) async {
    String _phone = "+91" + phone;
    var result = await DB().isWho(_phone);
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
        phone = "+91-" + phone;
        var verifier = RecaptchaVerifier(
          container: "Complete to get OTP",
        );
        try {
          _firebaseAuth.signInWithPhoneNumber(phone, verifier);
        } catch (e) {
          print(e);
          return e.message;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var rt;
    return Scaffold(
        backgroundColor: primaryColor,
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: contr,
          children: [
            Container(
              child: Image.asset('Images/img1.png'),
            ),
            Container(
              child: Image.asset('Images/img2.png'),
            ),
            Container(
              child: Image.asset('Images/img3.png'),
            ),
            Container(
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
                    Text(
                        "You will receive OTP on the below entered Mobile Number"),
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
                      color: Colors.blue,
                      onPressed: () async {
                        String phone = _mobController.text.trim();
                        rt = await authenticatePhone(phone);
                      },
                      child: Text(
                        "Send OTP",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
