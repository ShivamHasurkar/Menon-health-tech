import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/modals/Doctor.dart';
import 'package:menon_health_tech/screens/DoctorHome/PatientList.dart';
import 'package:menon_health_tech/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:menon_health_tech/widgets/Loading.dart';

class RegisterDoctor extends StatefulWidget {
  final String phone;
  RegisterDoctor(this.phone);
  @override
  _RegisterDoctorState createState() => _RegisterDoctorState(phone);
}

class _RegisterDoctorState extends State<RegisterDoctor> {
  Doctor d = Doctor();
  String phone;
  String fName, lName, email, degree, fee;
  File _image;
  ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  _RegisterDoctorState(this.phone);
  Widget _buildFName() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "First Name",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.perm_identity),
        labelText: ("First Name"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'First Name is Required';
        }

        return null;
      },
      onSaved: (value) {
        fName = value;
      },
    );
  }

  Widget _buildImagePicker() {
    return (Center(
      child: new Column(
        children: [
          Text(
            "Upload Degree/Licence Document for Verification",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          OutlineButton(onPressed: getImage, child: Icon(Icons.add_a_photo)),
        ],
      ),
    ));
  }

  Widget _buildLName() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "First Name",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.perm_identity),
        labelText: ("Last Name"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'This is Required';
        }

        return null;
      },
      onSaved: (value) {
        lName = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.mail),
        labelText: ("Email"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'This is Required';
        }

        return null;
      },
      onSaved: (value) {
        email = value;
      },
    );
  }

  Widget _buildDegree() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Degree",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.campaign),
        labelText: ("Degree"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'This is Required';
        }

        return null;
      },
      onSaved: (value) {
        degree = value;
      },
    );
  }

  Widget _buildFee() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Initial Consultation Fee",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.monetization_on),
        labelText: ("Consultation Fee"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'This is Required';
        }

        return null;
      },
      onSaved: (value) {
        degree = value;
      },
    );
  }

  final GlobalKey<FormState> _dFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Form(
            key: _dFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFName(),
                SizedBox(height: 10),
                _buildLName(),
                SizedBox(height: 10),
                _buildEmail(),
                SizedBox(height: 10),
                _buildFee(),
                SizedBox(height: 10),
                _buildDegree(),
                SizedBox(height: 10),
                _buildImagePicker(),
                SizedBox(height: 20),
                RaisedButton(
                    color: Colors.teal,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (!_dFormKey.currentState.validate() && _image == null)
                        return null;
                      _dFormKey.currentState.save();
                      d.consultationFee = fee;
                      d.degree = degree;
                      d.document = _image;
                      d.email = email;
                      d.firstName = fName;
                      d.lastName = lName;
                      d.verified = true;
                      d.phone = phone;

                      var rt = await DB().createDoctor(d);
                      if (rt == null) {
                        return Loading();
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientList(phone)));
                    }),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: _image == null
                      ? Text('No Document Selected.',
                          style: TextStyle(color: Colors.red))
                      : Text(
                          "Document Selected",
                          style: TextStyle(color: Colors.green),
                        ),
                ),
              ],
            )),
      ),
    );
  }
}
