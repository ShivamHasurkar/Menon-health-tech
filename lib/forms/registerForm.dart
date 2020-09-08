import 'package:flutter/material.dart';
import 'package:menon_health_tech/forms/registerDoctor.dart';
import 'package:menon_health_tech/forms/registerPatient.dart';

class RegisterForm extends StatefulWidget {
  final String phone;
  RegisterForm(this.phone);
  @override
  _RegisterFormState createState() => _RegisterFormState(phone);
}

class _RegisterFormState extends State<RegisterForm> {
  Widget form;
  String phone;
  _RegisterFormState(String phone) {
    this.phone = phone;
    form = RegisterPatient(phone);
  }
  bool patientForm = false;
  String _userType = "User Form";

  void changeForm(bool value) {
    print("Here");
    if (patientForm) {
      print(patientForm);
      setState(() {
        form = RegisterPatient(phone);
      });
      _userType = "User Form";
      patientForm = value;
    } else {
      setState(() {
        form = RegisterDoctor(phone);
      });
      patientForm = value;
      _userType = "Doctors Form";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Toggle User/Doctor",
            style: TextStyle(
                fontSize: 25, color: Colors.teal, fontWeight: FontWeight.w500),
          ),
          new Switch(value: patientForm, onChanged: changeForm),
          Text(
            _userType,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                decoration: TextDecoration.underline),
          ),
          form,
        ],
      ),
    ));
  }
}
