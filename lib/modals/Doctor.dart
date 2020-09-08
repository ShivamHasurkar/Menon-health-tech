import 'dart:io';

class Doctor {
  String firstName,
      lastName,
      licenceNo,
      dateOfBirth,
      degree,
      phone,
      email,
      consultationFee;
  File document;
  bool verified;

  Doctor(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.licenceNo,
      this.consultationFee,
      this.dateOfBirth,
      this.degree,
      this.verified,
      this.document});
}
