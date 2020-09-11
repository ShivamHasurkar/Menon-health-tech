import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future createUser(String phone, String pass) async {
    phone = phone + "@menon.in";

    var rt = await _auth.createUserWithEmailAndPassword(
        email: phone, password: pass);

    var user = rt.user;
    return user;
  }
}
