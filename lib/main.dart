import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menon_health_tech/forms/registerForm.dart';
import 'package:menon_health_tech/screens/Auth_web/AuthWeb.dart';
import 'package:menon_health_tech/screens/DoctorHome/DoctorHome_Mobile.dart';
import 'package:menon_health_tech/screens/DoctorHome/PatientList.dart';
import 'package:menon_health_tech/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:menon_health_tech/screens/Tutorial/tutorialCarousel.dart';

import 'firebase/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menon Health Tech Pvt. Ltd.',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

//State class for Splash Screen
class Splash extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Logo
    var assetsImage = new AssetImage(
        'Images/Menon and Menon Logo.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height: 300,
        width: 200); //<- Creates a widget that displays an image.
    //return with white background and logo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
              child: AspectRatio(
            aspectRatio: 3 / 2,
            child: image,
          )),
        ), //<- place where the image appears
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  final User _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (_user != null) {
      String phone = _user.phoneNumber;
      if (phone == null) {
        phone = _user.email.substring(0, 13);
        print(phone);
      }
      print("Main Dart");
      print(phone);
      return FutureBuilder(
          future: DB().isWho(phone),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return SplashScreen();
            else if (snapshot.data == "Doctor")
              return DoctorHome(phone);
            else if (snapshot.data == "Patient")
              return PatientHome(phone);
            else
              return RegisterForm(phone);
          });
    } else {
      print("User null");
      return SplashTime();
    }
  }
}

class SplashTime extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

//State class for Splash Screen
class _Splash extends State<SplashTime> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Time of 2 sec for splash screen
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              if (kIsWeb)
                return AuthWeb();
              else
                return TutorialCarousel();
            })));
    //Logo
    var assetsImage = new AssetImage(
        'Images/Menon and Menon Logo.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height: 300,
        width: 200); //<- Creates a widget that displays an image.
    //return with white background and logo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
              child: AspectRatio(
            aspectRatio: 3 / 2,
            child: image,
          )),
        ), //<- place where the image appears
      ),
    );
  }
}
