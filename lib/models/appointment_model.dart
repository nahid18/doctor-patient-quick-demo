import 'package:doctor_patient/models/doctor_model.dart';

class Appointment {
  int id;
  String patientId;
  int dateTime;
  String doctorId;
  Doctor doctor;
  int status;

  Appointment({this.id, this.patientId, this.dateTime, this.doctorId, this.doctor, this.status});

  Appointment.fromMap(Map map) {
    id = map[id];
    patientId = map[patientId];
    dateTime = map[dateTime];
    doctorId = map[doctorId];
    doctor = map[doctor];
    status = map[status];
  }




}

// patientid TEXT, datetime TEXT, doctorid TEXT) .toIso8601String()