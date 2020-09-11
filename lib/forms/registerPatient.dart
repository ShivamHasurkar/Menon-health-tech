import 'package:flutter/material.dart';
import 'package:menon_health_tech/firebase/auth.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/modals/Patient.dart';
import 'package:menon_health_tech/screens/DoctorsList/DoctorsList.dart';
import 'package:menon_health_tech/screens/PatientHome/PatientHome_Mobile.dart';

class RegisterPatient extends StatefulWidget {
  final String phone;

  RegisterPatient(this.phone);
  @override
  _RegisterPatientState createState() => _RegisterPatientState(phone);
}

class _RegisterPatientState extends State<RegisterPatient> {
  String phone, gender, covid, pass, cPass;
  int age;
  DateTime selectedDate;
  _RegisterPatientState(this.phone);
  Patient p;

  Future pickDate() async {
    print("Pick Date");
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2020),
        firstDate: DateTime(1900),
        lastDate: DateTime(2200));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        age = DateTime.now().year - selectedDate.year;
        print(selectedDate.year);
        print(age);
      });
  }

  Widget _buildGender() {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: "Gender",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          prefixIcon: Icon(Icons.people),
          labelText: ("Gender"),
        ),
        items: ["Male", "Female", "Other"]
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (String selected) {
          setState(() {
            gender = selected;
            print(gender);
          });
        });
  }

  Widget _buildCovid() {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: "Covid Status",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          prefixIcon: Icon(Icons.coronavirus),
          labelText: ("Covid Status"),
        ),
        items: ["Suspect", "Precautionary", "Patient"]
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (String selected) {
          setState(() {
            covid = selected;
            print(gender);
          });
        });
  }

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
        p.firstName = value;
      },
    );
  }

  Widget _buildDOB() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Date of Birth",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(icon: Icon(Icons.calendar_today), onPressed: pickDate),
        () {
          if (selectedDate == null) {
            return Text(
              "Click on Icon to Select",
              style: TextStyle(fontSize: 18, color: Colors.orange),
            );
          } else {
            return Text(
                selectedDate.day.toString() +
                    "-" +
                    selectedDate.month.toString() +
                    "-" +
                    selectedDate.year.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold));
          }
        }()
      ],
    );
  }

  Widget _buildLName() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Last Name",
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
        p.lastName = value;
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
        // ignore: unrelated_type_equality_check
        return null;
      },
      onSaved: (value) {
        p.email = value;
      },
    );
  }

  Widget _buildHeight() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Height (CM)",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.arrow_circle_up),
        labelText: ("Height"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'This is Required';
        }

        return null;
      },
      onSaved: (value) {
        p.height = value;
      },
    );
  }

  Widget _buildWeight() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Weight (KG)",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.linear_scale),
        labelText: ("Weight"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'This is Required';
        }

        return null;
      },
      onSaved: (value) {
        p.weight = value;
      },
    );
  }

  Widget _buildPass() {
    return TextFormField(
      maxLength: 10,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.linear_scale),
        labelText: ("Password"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'This is Required';
        }
        if (value.length < 6) {
          return "Too Short";
        }

        return null;
      },
      onSaved: (value) {
        pass = value;
      },
    );
  }

  Widget _buildCPass() {
    return TextFormField(
      maxLength: 10,
      decoration: InputDecoration(
        hintText: "Confirm Password",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(Icons.linear_scale),
        labelText: ("Confirm Password"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return 'This is Required';
        }
        if (value.length < 6) {
          return "Too Short";
        }
        if (value != pass) {
          return "Password Mismatch";
        }

        return null;
      },
      onSaved: (value) {
        cPass = value;
      },
    );
  }

  final GlobalKey<FormState> _pFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      child: Form(
          key: _pFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFName(),
                SizedBox(height: 10),
                _buildLName(),
                SizedBox(height: 10),
                _buildEmail(),
                SizedBox(height: 10),
                _buildHeight(),
                SizedBox(height: 10),
                _buildWeight(),
                SizedBox(height: 10),
                _buildGender(),
                SizedBox(height: 10),
                _buildCovid(),
                SizedBox(height: 10),
                _buildPass(),
                SizedBox(height: 10),
                _buildCPass(),
                SizedBox(height: 10),
                _buildDOB(),
                SizedBox(height: 20),
                RaisedButton(
                    color: Colors.teal,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (!_pFormKey.currentState.validate()) return;
                      p = Patient();
                      _pFormKey.currentState.save();
                      p.dob = selectedDate;
                      p.phone = phone;
                      p.age = age.toString();
                      p.gender = gender;
                      p.covidStatus = covid;
                      var rt = await DB().createPatient(p, pass);
                      if (rt == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CircularProgressIndicator();
                          },
                        );
                      } else
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PatientHome(phone)));
                    }),
              ],
            ),
          )),
    );
  }
}
