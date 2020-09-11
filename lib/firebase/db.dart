import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:menon_health_tech/firebase/auth.dart';
import 'package:menon_health_tech/modals/Doctor.dart';
import 'package:menon_health_tech/modals/HealthDataEntry.dart';
import 'package:menon_health_tech/modals/Patient.dart';

class DB {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance.ref();

  Future<String> isWho(String phone) async {
    print(phone);
    QuerySnapshot data =
        await _db.collection("Doctor").where("phone", isEqualTo: phone).get();
    if (data.docs.length > 0) {
      print("doctor");
      return "Doctor";
    }

    data =
        await _db.collection("Patients").where("phone", isEqualTo: phone).get();
    if (data.docs.length > 0) {
      print("isWho: Patient");
      return "Patient";
    }

    print("no user");
    return "new";
  }

  Future<bool> createPatient(Patient patient, String pass) async {
    bool rt = false;
    
    Auth().createUser(patient.phone, pass);
    try {
      await _db.collection("Patients").doc(patient.phone).set({
        "firstName": patient.firstName,
        "lastName": patient.lastName,
        "phone": patient.phone,
        "email": patient.email,
        "height": patient.height,
        "weight": patient.weight,
        "Age": patient.age,
        "Date of Birth": patient.dob,
        "covidStatus": patient.covidStatus,
      });
      rt = true;
      print(rt);
    } catch (e) {
      print(e.message);
    }

    return rt;
  }

  Future<bool> createDoctor(Doctor doctor) async {
    bool rt = false;

    try {
      var path =
          _storage.child(doctor.firstName + "-" + doctor.lastName + ".jpg");
      path.putFile(doctor.document);
    } catch (e) {
      print("Cannot Upload Document");
      print(e);
    }

    try {
      await _db.collection("Doctor").doc(doctor.phone).set({
        "firstName": doctor.firstName,
        "lastName": doctor.lastName,
        "phone": doctor.phone,
        "email": doctor.email,
        "licenceNo": doctor.licenceNo,
        "degree": doctor.degree,
        "verifed": true,
        "consultationFee": doctor.consultationFee,
      });
      rt = true;
    } catch (e) {
      print(e);
      print("Catch CreateDoctor");
      rt = false;
    }
    return rt;
  }

  Future<bool> addHealthData(String phone, HealthDataEntry h) async {
    bool rt = false;
    try {
      await _db
          .collection("Patients")
          .doc(phone)
          .collection("HealthData")
          .doc(Timestamp.now().toDate().toString())
          .set({
        "Date": Timestamp.now().toDate().toString(),
        "Temprature": h.temprature,
        "Oxygen Level": h.oxy,
        "Pulse": h.pulse,
        "Cough": h.cough,
        "Cold": h.cold,
        "Cough Type": h.coughType,
        "Cough Severity": h.coughSevarity,
        "Loss of Smell": h.lossofSmell,
        "Loss of Taste": h.lossofTaste,
        "Other": h.other,
      });
      rt = true;
    } catch (e) {
      print(e.message);
    }
    return rt;
  }

  Future<List<HealthDataEntry>> readHealthData(String phone) async {
    List<HealthDataEntry> hs = List<HealthDataEntry>();
    print("Reading Data");
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("HealthData")
          .get();

      data.docs.forEach((element) {
        var d = element.data();
        print(d);
        HealthDataEntry h = HealthDataEntry();
        h.cold = d["Cold"];
        h.cough = d["Cough"];
        h.temprature = d["Temprature"];
        h.lossofSmell = d["Loss of Smell"];
        h.lossofTaste = d["Loss of Taste"];
        // h.coughType = d["Cough Type"];
        // h.coughSevarity = d["Cough Severity"];
        h.pulse = d["Pulse"];
        h.other = d["Other"];
        h.oxy = d["Oxygen Level"];
        //h.dataTime = d["Date"];
        h.date = d["Date"].toString();

        hs.add(h);
        print(" inside DB ");
      });

      return hs;
    } catch (e) {
      print(e);
    }
    print("returning health records");
  }

  Future<List<Doctor>> getDoctors() async {
    List<Doctor> doctors = [];
    try {
      QuerySnapshot data = await _db.collection("Doctor").get();

      data.docs.forEach((element) {
        var d = element.data();
        // print(d);
        Doctor da = Doctor();
        da.consultationFee = d["consultationFee"];
        da.dateOfBirth = d["dateOfBirth"];
        da.degree = d["degree"];
        da.email = d["email"];
        da.firstName = d["firstName"];
        da.lastName = d["lastName"];
        da.licenceNo = d["licenceNo"];
        da.phone = d["phone"];
        da.verified = d["verifed"];
        doctors.add(da);
        print(d["verifed"]);
      });
      return doctors;
    } catch (e) {
      print(e.message);
    }

    return doctors;
  }

  Future<List<Patient>> getPatient(String docNumber) async {
    List<Patient> patients = [];
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(docNumber)
          .collection("Patient")
          .get();
      var doc = data.docs;

      for (var i = 0; i < doc.length; i++) {
        String d = doc[i].data()["PatientNumber"];
        t = await _db.collection("Patients").doc(d).get();
        Patient p = Patient();
        p.firstName = t.data()["firstName"];
        p.lastName = t.data()["lastName"];
        p.email = t.data()["email"];
        p.phone = t.data()["phone"];
        p.weight = t.data()["weight"];
        p.height = t.data()["height"];
        patients.add(p);
      }
    } catch (e) {
      print(e.message);
    }
    return patients;
  }

  Future<bool> addPatienttoDoctor(String pN, String dN) async {
    try {
      await _db.collection("Doctor").doc(dN).collection("Patient").doc(pN).set({
        "PatientNumber": pN,
        "Date Added": Timestamp.now().toDate().toString(),
      });
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Doctors")
          .doc(dN)
          .set({
        "DoctorNumber": pN,
        "Date Added": Timestamp.now().toDate().toString(),
      });
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<Patient> getUser(String phone) async {
    Patient p = Patient();
    try {
      var ss = await _db
          .collection("Patients")
          .where("phone", isEqualTo: phone)
          .get();

      var data = ss.docs[0].data();
      if (data != null) {
        p.firstName = data["firstName"];
        p.lastName = data["lastName"];
        p.gender = data["gender"];
        p.covidStatus = data["covidStatus"];
        p.weight = data["weight"];
        p.height = data["height"];
        p.age = data["age"];
        p.email = data["email"];
        p.phone = phone;
        return p;
      }
    } catch (e) {
      print(e);
    }
  }
}
